import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/model/person_details.dart';

class KnownForList extends StatefulWidget {
  final data;

  KnownForList(this.data);

  @override
  _KnownForListState createState() => _KnownForListState();
}

class _KnownForListState extends State<KnownForList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
            children: widget.data.map<Widget>((PersonDetailsModel item) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, 'details',
                      arguments: {"show": item.embedded.show});
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: item.embedded.show.image.medium == null
                            ? Container(
                                color: colors["dark_primary"],
                                height: 210,
                                width: 150,
                                child: Icon(
                                  Icons.broken_image,
                                  color: colors['red_primary'],
                                  size: 42,
                                ),
                              )
                            : Image.network(
                                item.embedded.show.image.medium,
                                height: 210,
                                width: 150,
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
    );
  }
}
