import 'package:flutter/material.dart';
import 'package:tv_test/blocs/search_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/search.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/widgets/common/show_tile.dart';

class Search extends SearchDelegate<Show> {
  final list;
  final SearchBloc bloc = SearchBloc();

  Search(this.list);

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
    bloc.searchQuery(query);

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
              builder: (context, AsyncSnapshot<List<SearchModel>> snapshot) {
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
                    itemCount: results.length,
                    itemBuilder: (context, index) =>
                        ShowTile(results[index].show),
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
        itemCount: list.length,
        itemBuilder: (context, index) => ShowTile(list[index]),
      ),
    );
  }
}
