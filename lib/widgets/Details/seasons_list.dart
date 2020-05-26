import 'package:flutter/material.dart';
import 'package:mazetvapp/handlers/color_handler.dart';
import 'package:mazetvapp/widgets/details/episodes_dialog.dart';

class SeasonsList extends StatefulWidget {
  final seasons;
  final episodes;

  SeasonsList(this.seasons, this.episodes);

  @override
  _SeasonsListState createState() => _SeasonsListState();
}

class _SeasonsListState extends State<SeasonsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.seasons
          .map<Widget>(
            (season) => Theme(
              data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                  accentColor: colors['red_primary']),
              child: ExpansionTile(
                title: Text(
                  "Season ${season.number.toString()}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                children: widget.episodes
                    .map<Widget>(
                      (episode) => episode.season == season.number
                          ? Container(
                              decoration:
                                  BoxDecoration(color: colors["dark_primary"]),
                              margin: EdgeInsets.symmetric(vertical: 2.0),
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          EpisodesDialog(episode));
                                },
                                title: Text(episode.name.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                trailing: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                leading: episode.image.medium != null
                                    ? Image.network(
                                        episode.image.medium,
                                        width: 100,
                                      )
                                    : Container(
                                        width: 24,
                                        height: 24,
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            color: colors['red_primary'],
                                            size: 18,
                                          ),
                                        ),
                                      ),
                              ),
                            )
                          : Container(),
                    )
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}
