import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mazetvapp/model/show.dart';

class ShowTile extends StatefulWidget {
  final Show show;

  ShowTile(this.show);

  @override
  _ShowTileState createState() => _ShowTileState();
}

class _ShowTileState extends State<ShowTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'details',
            arguments: {"show": widget.show});
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                height: 120,
                imageUrl: widget.show.image.medium == null
                    ? ''
                    : widget.show.image.medium,
                placeholder: (context, string) => Container(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, string, d) => Container(
                  height: 60,
                  decoration: BoxDecoration(color: Colors.black),
                  width: 60,
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                '${widget.show.name}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
