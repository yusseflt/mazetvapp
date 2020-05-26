import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/widgets/home/search_show.dart';
import 'package:mazetvapp/widgets/people/search_actor.dart';

class SearchBar extends StatefulWidget {
  final query;
  final data;
  final type;

  SearchBar(this.query, this.data, this.type);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: colors['dark_primary'],
          borderRadius: BorderRadius.circular(4.0)),
      child: InkWell(
        onTap: () {
          showSearch(
            context: context,
            delegate: widget.type == 'show'
                ? SearchShow(widget.data)
                : SearchActor(widget.data),
            query: widget.query,
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
    );
  }
}
