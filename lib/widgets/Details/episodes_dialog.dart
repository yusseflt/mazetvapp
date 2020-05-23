import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/handlers/text_handler.dart';
import 'package:tv_test/model/embeded.dart';

class EpisodesDialog extends StatefulWidget {
  final Episode episode;

  EpisodesDialog(this.episode);
  @override
  _EpisodesDialogState createState() => _EpisodesDialogState();
}

class _EpisodesDialogState extends State<EpisodesDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(),
      backgroundColor: colors['dark_background'],
      children: <Widget>[
        CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
          imageUrl: widget.episode.image.original ?? '',
          placeholder: (context, string) => Container(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, string, d) => Container(
            height: 100,
            child: Center(
              child: Icon(
                Icons.broken_image,
                color: colors['red_primary'],
                size: 36,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.episode.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Season ${widget.episode.season} - Episode ${widget.episode.number}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                width: 400,
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        widget.episode.summary != ''
                            ? removeTags(widget.episode.summary)
                            : "There's no summary",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              FlatButton(
                color: colors["red_primary"],
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
