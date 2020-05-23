import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/details_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/handlers/text_handler.dart';
import 'package:tv_test/model/show.dart';

class DetailsPage extends StatefulWidget {
  final Show show;

  DetailsPage(this.show);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsBloc bloc = DetailsBloc();
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    bloc.getShowById(widget.show.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 487 / 451,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: widget.show.image.original == null
                    ? null
                    : CachedNetworkImageProvider(widget.show.image.original),
              )),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  colors["dark_background"].withOpacity(0.2),
                  colors["dark_background"],
                ],
              ),
            ),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.show.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.show.premiered != null
                            ? '${widget.show.premiered.year} - ${widget.show.runtime} min per episode'
                            : '${widget.show.runtime} min per episode',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        children: widget.show.genres.map<Widget>((genre) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: colors["red_primary"], width: 1.5),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Text(
                              genre,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: <Widget>[
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            height: expanded == true ? null : 80,
                            child: Text(
                              removeTags(widget.show.summary),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: RotatedBox(
                                quarterTurns: expanded ? 2 : 0,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Object>(
                    stream: bloc.detailsObservable,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ExpansionTile(title: null);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
