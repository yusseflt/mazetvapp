import 'package:flutter/material.dart';
import 'package:tv_test/blocs/search_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/embeded.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/widgets/common/people_card.dart';
import 'package:tv_test/widgets/common/show_tile.dart';

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
