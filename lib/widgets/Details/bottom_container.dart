import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/handlers/text_handler.dart';
import 'package:mazetvapp/widgets/details/cast_list.dart';
import 'package:mazetvapp/widgets/details/seasons_list.dart';

class BottomContainer extends StatefulWidget {
  final data;
  final show;

  BottomContainer(this.data, this.show);

  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  bool expandedSummary = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors["dark_background"],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Text(
              'Summary',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(16.0),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            height: expandedSummary == true ? null : 80,
            child: Text(
              removeTags(widget.show.summary),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                expandedSummary = !expandedSummary;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: RotatedBox(
                quarterTurns: expandedSummary ? 2 : 0,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
          widget.data["embedded"].cast.isEmpty
              ? Container()
              : CastList(widget.data["embedded"].cast),
          SeasonsList(
              widget.data["embedded"].seasons, widget.data["embedded"].episodes)
        ],
      ),
    );
  }
}
