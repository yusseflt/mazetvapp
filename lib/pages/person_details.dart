import 'package:flutter/material.dart';
import 'package:mazetvapp/blocs/person_details_bloc.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/handlers/text_handler.dart';
import 'package:mazetvapp/model/embeded.dart';
import 'package:mazetvapp/model/person_details.dart';
import 'package:mazetvapp/pages/details.dart';
import 'package:mazetvapp/widgets/personDetails/known_for_list.dart';
import 'package:mazetvapp/widgets/personDetails/person_details_top.dart';

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
                  PersonDetailsTop(widget.person),
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
                        KnownForList(snapshot.data)
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
