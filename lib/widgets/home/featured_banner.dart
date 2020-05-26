import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/model/show.dart';
import 'package:mazetvapp/pages/details.dart';

class FeaturedBanner extends StatefulWidget {
  final Show show;

  FeaturedBanner(this.show);

  @override
  _FeaturedBannerState createState() => _FeaturedBannerState();
}

class _FeaturedBannerState extends State<FeaturedBanner> {
  @override
  Widget build(BuildContext context) {
    return widget.show.image.medium == null
        ? Container()
        : InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    widget.show,
                  ),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 451 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.topCenter,
                        image: CachedNetworkImageProvider(
                            widget.show.image.medium),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(
                    color: colors["dark_primary"],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.show.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.show.premiered.year.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
