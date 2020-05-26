import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/model/show.dart';
import 'package:mazetvapp/pages/details.dart';

class ShowCard extends StatefulWidget {
  final Show show;
  final bloc;
  final height;
  final width;

  ShowCard(this.show, this.bloc, this.height, this.width);
  @override
  _ShowCardState createState() => _ShowCardState();
}

class _ShowCardState extends State<ShowCard> {
  NetworkImage img;
  Color c = Colors.black;
  Color textColor = Colors.white;

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
    img = NetworkImage(
        widget.show.image.medium == null ? '' : widget.show.image.medium);
  }

  @override
  void didUpdateWidget(ShowCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    img = NetworkImage(widget.show.image.medium);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      height: widget.height,
      width: widget.width,
      decoration: c == null
          ? BoxDecoration(color: colors["dark_primary"])
          : BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: c,
              border: Border.all(color: c, width: 2),
            ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'details',
              arguments: {"show": widget.show, "favoritesBloc": widget.bloc});
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
