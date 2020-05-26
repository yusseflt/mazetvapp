import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/handlers/text_handler.dart';
import 'package:mazetvapp/model/embeded.dart';
import 'package:mazetvapp/pages/person_details.dart';

class PeopleCard extends StatefulWidget {
  final Person person;

  PeopleCard(this.person);

  @override
  _PeopleCardState createState() => _PeopleCardState();
}

class _PeopleCardState extends State<PeopleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetails(widget.person)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
            color: colors["dark_primary"],
            borderRadius: BorderRadius.circular(18.0)),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.person.image.medium != null
                    ? widget.person.image.medium
                    : '',
                placeholder: (context, string) => Container(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, s, d) => Container(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: colors['red_primary'],
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.person.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Birth date: ${convertDate(widget.person.birthday)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Country: ${widget.person.country.name == null ? 'Not available' : widget.person.country.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
