import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mazetvapp/blocs/search_bloc.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/model/show.dart';
import 'package:mazetvapp/widgets/common/people_card.dart';
import 'package:mazetvapp/widgets/common/show_tile.dart';

class SearchActor extends SearchDelegate<Show> {
  final list;
  final SearchBloc bloc = SearchBloc();

  SearchActor(this.list);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.searchQuery(query, 'people');

    return query == ''
        ? Container(
            color: colors['dark_background'],
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => ShowTile(list[index]),
            ),
          )
        : Container(
            color: colors['dark_background'],
            child: StreamBuilder(
              stream: bloc.searchObservable,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else if (snapshot.data.length == 0) {
                  return Column(
                    children: <Widget>[
                      Text(
                        "No Results Found.",
                      ),
                    ],
                  );
                } else {
                  var results = snapshot.data;
                  return ListView.builder(
                    itemExtent: 160.0,
                    itemCount: results.length,
                    itemBuilder: (context, index) => PeopleCard(results[index]),
                  );
                }
              },
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '') {
      Future.delayed(Duration(seconds: 2), () {
        bloc.searchQuery(query, 'people');
      });
      return Container(
        color: colors['dark_background'],
        child: StreamBuilder(
          stream: bloc.searchObservable,
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Results Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                itemExtent: 160.0,
                itemCount: results.length,
                itemBuilder: (context, index) => PeopleCard(results[index]),
              );
            }
          },
        ),
      );
    } else {
      return Container(
        color: colors['dark_background'],
        child: ListView.builder(
          itemExtent: 160.0,
          itemCount: list.length,
          itemBuilder: (context, index) => PeopleCard(list[index].person),
        ),
      );
    }
  }
}
