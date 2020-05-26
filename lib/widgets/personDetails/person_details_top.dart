import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/border_handler.dart';
import 'package:mazetvapp/handlers/color_handler.dart';

class PersonDetailsTop extends StatefulWidget {
  final person;

  PersonDetailsTop(this.person);

  @override
  _PersonDetailsTopState createState() => _PersonDetailsTopState();
}

class _PersonDetailsTopState extends State<PersonDetailsTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors["dark_primary"],
      child: ClipPath(
        clipper: BorderHandler(),
        child: SafeArea(
          child: Container(
            color: colors["dark_background"],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(36.0)),
                      child: widget.person.image.original == null
                          ? Container(
                              width: 42,
                              height: 42,
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: colors['red_primary'],
                                  size: 48,
                                ),
                              ),
                            )
                          : Image.network(
                              widget.person.image.original,
                              alignment: FractionalOffset.topCenter,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
