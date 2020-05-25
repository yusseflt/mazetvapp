import 'package:flutter/material.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/widgets/common/show_card.dart';

class FavoritesPage extends StatefulWidget {
  final bloc;

  FavoritesPage(this.bloc);
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    widget.bloc.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: StreamBuilder(
        stream: widget.bloc.fevoritesObservable,
        builder: (context, AsyncSnapshot<List<Show>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data.isEmpty) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  SafeArea(
                    child: Text(
                      'Favorites',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'This list is empty :(',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                SafeArea(
                    child: Text(
                  'Favorites',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Wrap(
                        direction: Axis.horizontal,
                        children: snapshot.data
                            .map<Widget>((show) => ShowCard(
                                  show,
                                  widget.bloc,
                                  MediaQuery.of(context).size.height / 2.7,
                                  MediaQuery.of(context).size.width / 2.5,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
