import 'package:flutter/material.dart';
import 'package:tv_test/blocs/people_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/embeded.dart';
import 'package:tv_test/widgets/common/people_card.dart';
import 'package:tv_test/widgets/people/search_actor.dart';

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
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: colors['dark_primary'],
                        borderRadius: BorderRadius.circular(4.0)),
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchActor(snapshot.data),
                          query: query,
                        );
                      },
                      child: IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: colors['dark_secondary'],
                            ),
                            labelText: 'Search',
                            labelStyle: TextStyle(
                              color: colors['dark_secondary'],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: colors['red_primary'],
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
