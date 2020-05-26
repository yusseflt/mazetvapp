import 'package:flutter/material.dart';
import 'package:mazetvapp/blocs/details_bloc.dart';
import 'package:mazetvapp/blocs/favorites_bloc.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/handlers/text_handler.dart';
import 'package:mazetvapp/model/show.dart';
import 'package:mazetvapp/widgets/details/bottom_container.dart';
import 'package:mazetvapp/widgets/details/cast_list.dart';
import 'package:mazetvapp/widgets/details/seasons_list.dart';

class DetailsPage extends StatefulWidget {
  final arguments;

  DetailsPage(this.arguments);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsBloc bloc = DetailsBloc();
  FavoritesBloc favoritesBloc;

  Show show;

  @override
  void initState() {
    super.initState();
    show = widget.arguments["show"];
    favoritesBloc = widget.arguments["favoritesBloc"];

    bloc.getShowById(show);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: StreamBuilder(
          stream: bloc.detailsObservable,
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                show.image.original == null
                    ? Container()
                    : AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: NetworkImage(show.image.original),
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
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                          snapshot.hasData == true
                              ? IconButton(
                                  onPressed: () {
                                    bloc.addToDB(show, favoritesBloc);
                                  },
                                  icon: Icon(
                                      snapshot.data["favorited"] == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: snapshot.data["favorited"] == true
                                          ? colors["red_primary"]
                                          : Colors.white),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(height: 100),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              show.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              show.premiered != null
                                  ? '${show.premiered.year} - ${show.runtime} min per episode'
                                  : show.runtime != null
                                      ? '${show.runtime} min per episode'
                                      : '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              children: show.genres.map<Widget>((genre) {
                                return Container(
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: colors["red_primary"],
                                          width: 1.5),
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
                          ],
                        ),
                      ),
                      !snapshot.hasData
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : BottomContainer(snapshot.data, show)
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
