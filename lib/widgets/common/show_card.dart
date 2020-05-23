import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/pages/details.dart';

class ShowCard extends StatefulWidget {
  final Show show;
  ShowCard(this.show);
  @override
  _ShowCardState createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsPage(widget.show)));
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(
                    widget.show.image.medium == null
                        ? ''
                        : widget.show.image.medium),
              ),
            ),
          ),
          Flexible(
            child: Text(
              '${widget.show.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                        // bottomLeft
                        offset: Offset(-0.8, -0.8),
                        color: Colors.black),
                    Shadow(
                        // bottomRight
                        offset: Offset(0.8, -0.8),
                        color: Colors.black),
                    Shadow(
                        // topRight
                        offset: Offset(0.8, 0.8),
                        color: Colors.black),
                    Shadow(
                        // topLeft
                        offset: Offset(-0.8, 0.8),
                        color: Colors.black),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
