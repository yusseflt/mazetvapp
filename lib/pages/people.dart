import 'package:flutter/material.dart';
import 'package:mazetvapp/blocs/people_bloc.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/model/embeded.dart';
import 'package:mazetvapp/widgets/common/people_card.dart';
import 'package:mazetvapp/widgets/common/search_bar.dart';
import 'package:mazetvapp/widgets/people/search_actor.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final PeopleBloc bloc = PeopleBloc();

  String query = '';

  @override
  void initState() {
    super.initState();

    bloc.getInitialActors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
            stream: bloc.peopleObservable,
            builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Column(
                children: <Widget>[
                  SafeArea(
                    child: Text(
                      'Actors',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SearchBar(query, snapshot.data, 'people'),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      itemExtent: 160.0,
                      children: snapshot.data
                          .map((people) => PeopleCard(people.person))
                          .toList(),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
