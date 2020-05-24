import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/pages/details.dart';

class ShowCard extends StatefulWidget {
  final Show show;
  final bloc;
  ShowCard(this.show, this.bloc);
  @override
  _ShowCardState createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  CachedNetworkImageProvider img;
  Color c;
  Color textColor;

  Future<Color> getImagePalette() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(img);

    var dominantColor = paletteGenerator.dominantColor.color.value.toInt();
    var white = Colors.white.value.toInt();
    var black = Colors.black.value.toInt();

    if (white - dominantColor > dominantColor - black) {
      textColor = Colors.white;
    } else {
      textColor = Colors.black;
    }

    return paletteGenerator.dominantColor.color;
  }

  @override
  void initState() {
    super.initState();
    img = CachedNetworkImageProvider(widget.show.image.medium);

    if (widget.show.image.medium != null) {
      getImagePalette().then((color) {
        setState(() {
          c = color;
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    img = CachedNetworkImageProvider(widget.show.image.medium);

    if (widget.show.image.medium != null) {
      getImagePalette().then((color) {
        setState(() {
          c = color;
        });
      });
    }
  }

  @override
  void didUpdateWidget(ShowCard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    img = CachedNetworkImageProvider(widget.show.image.medium);

    if (widget.show.image.medium != null) {
      getImagePalette().then((color) {
        setState(() {
          c = color;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height / 2.7,
      width: MediaQuery.of(context).size.width / 2.4,
      decoration: c == null
          ? BoxDecoration(color: colors["dark_primary"])
          : BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: c,
              border: Border.all(color: c, width: 2),
            ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        widget.show,
                        favoriteBloc: widget.bloc,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  image: img == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.fill,
                          image: img,
                        ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(4.0),
              child: Text(
                '${widget.show.name}',
                style: TextStyle(
                  color: textColor == null ? Colors.white : textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
