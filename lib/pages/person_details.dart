import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/person_details_bloc.dart';
import 'package:tv_test/handlers/border_handler.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/handlers/text_handler.dart';
import 'package:tv_test/model/embeded.dart';
import 'package:tv_test/model/person_details.dart';
import 'package:tv_test/pages/details.dart';
import 'package:tv_test/widgets/common/show_card.dart';

class PersonDetails extends StatefulWidget {
  final Person person;

  PersonDetails(this.person);

  @override
  _PersonDetailsState createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  PersonDetailsBloc bloc = PersonDetailsBloc();

  @override
  void initState() {
    super.initState();
    bloc.getActorById(widget.person.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: StreamBuilder(
          stream: bloc.personDetailsObservable,
          builder: (context, AsyncSnapshot<List<PersonDetailsModel>> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Container(
                    color: colors["dark_primary"],
                    child: ClipPath(
                      clipper: BorderHandler(),
                      child: SafeArea(
                        child: Container(
                          color: colors["dark_background"],
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height:
                                    MediaQuery.of(context).size.height / 1.8,
                                child: AspectRatio(
                                  aspectRatio: 487 / 451,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(36.0)),
                                    child: CachedNetworkImage(
                                      alignment: FractionalOffset.topCenter,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          widget.person.image.original != null
                                              ? widget.person.image.original
                                              : '',
                                      placeholder: (context, string) =>
                                          Container(
                                        height: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, s, d) => Container(
                                        width: 42,
                                        height: 42,
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            color: colors['red_primary'],
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: colors["dark_primary"],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.person.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Birth date: ${convertDate(widget.person.birthday)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Gender: ${widget.person.gender == null ? 'Not available' : widget.person.gender}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Country: ${widget.person.country.name == null ? 'Not available' : widget.person.country.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Death date: ${widget.person.deathday == null ? 'Alive' : convertDate(widget.person.deathday)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Known for',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          height: 320,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data
                                .map<Widget>((PersonDetailsModel item) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(item.embedded.show)));
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        child: CachedNetworkImage(
                                          height: 210,
                                          width: 150,
                                          imageUrl: item.embedded.show.image
                                                      .medium ==
                                                  null
                                              ? ''
                                              : item.embedded.show.image.medium,
                                          placeholder: (context, string) =>
                                              Container(
                                            height: 100,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                          errorWidget: (context, s, d) =>
                                              Container(
                                            color: colors["dark_primary"],
                                            height: 210,
                                            width: 150,
                                            child: Icon(
                                              Icons.broken_image,
                                              color: colors['red_primary'],
                                              size: 42,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: Center(
                                        child: Text(
                                          item.embedded.show.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
