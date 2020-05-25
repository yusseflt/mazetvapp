import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/details_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/handlers/text_handler.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/pages/person_details.dart';
import 'package:tv_test/widgets/details/episodes_dialog.dart';

class DetailsPage extends StatefulWidget {
  final Show show;
  final favoriteBloc;

  DetailsPage(this.show, {this.favoriteBloc});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsBloc bloc = DetailsBloc();
  bool expandedSummary = false;

  @override
  void initState() {
    super.initState();
    bloc.getShowById(widget.show);
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
                widget.show.image.original == null
                    ? Container()
                    : AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: NetworkImage(widget.show.image.original),
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
                                    bloc.addToDB(
                                        widget.show, widget.favoriteBloc);
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
                                  : widget.show.runtime != null
                                      ? '${widget.show.runtime} min per episode'
                                      : '',
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
                          : Container(
                              decoration: BoxDecoration(
                                color: colors["dark_background"],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0, top: 16.0),
                                    child: Text(
                                      'Summary',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    padding: EdgeInsets.all(16.0),
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                    height: expandedSummary == true ? null : 80,
                                    child: Text(
                                      removeTags(widget.show.summary),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        expandedSummary = !expandedSummary;
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: RotatedBox(
                                        quarterTurns: expandedSummary ? 2 : 0,
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                  snapshot.data["embedded"].cast.isEmpty
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text(
                                                'Cast',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 120.0,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                children: snapshot
                                                    .data["embedded"].cast
                                                    .map<Widget>(
                                                      (person) => Container(
                                                        width: 100.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              height: 60.0,
                                                              width: 60.0,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              PersonDetails(person.person)));
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(person
                                                                          .person
                                                                          .image
                                                                          .medium),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              person
                                                                  .person.name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                  Column(
                                    children: snapshot.data["embedded"].seasons
                                        .map<Widget>(
                                          (season) => Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    Colors.white,
                                                accentColor:
                                                    colors['red_primary']),
                                            child: ExpansionTile(
                                              title: Text(
                                                "Season ${season.number.toString()}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              children:
                                                  snapshot
                                                      .data["embedded"].episodes
                                                      .map<Widget>(
                                                        (episode) =>
                                                            episode.season ==
                                                                    season
                                                                        .number
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                                colors["dark_primary"]),
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            2.0),
                                                                    child:
                                                                        ListTile(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                EpisodesDialog(episode));
                                                                      },
                                                                      title: Text(
                                                                          episode
                                                                              .name
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16)),
                                                                      trailing:
                                                                          Icon(
                                                                        Icons
                                                                            .info_outline,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                      leading: episode.image.medium !=
                                                                              null
                                                                          ? Image
                                                                              .network(
                                                                              episode.image.medium,
                                                                              width: 100,
                                                                            )
                                                                          : Container(
                                                                              width: 24,
                                                                              height: 24,
                                                                              child: Center(
                                                                                child: Icon(
                                                                                  Icons.broken_image,
                                                                                  color: colors['red_primary'],
                                                                                  size: 18,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                      )
                                                      .toList(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
