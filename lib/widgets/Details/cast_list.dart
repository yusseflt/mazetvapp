import 'package:flutter/material.dart';
import 'package:mazetvapp/pages/person_details.dart';

class CastList extends StatefulWidget {
  final cast;

  CastList(this.cast);

  @override
  _CastListState createState() => _CastListState();
}

class _CastListState extends State<CastList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
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
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: widget.cast
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
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(person.person.image.medium),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          person.person.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
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
    );
  }
}
