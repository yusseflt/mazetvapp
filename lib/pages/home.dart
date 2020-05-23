import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/home_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/widgets/common/show_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = HomeBloc();
  final ScrollController _controller = ScrollController();
  bool loadingMore;
  int page;

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      page++;
      await bloc.getShows(page);
    }
  }

  @override
  void initState() {
    super.initState();

    page = 1;
    loadingMore = true;

    bloc.getShows(page);
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors["dark_background"],
      body: StreamBuilder(
          stream: bloc.homeObservable,
          builder: (context, AsyncSnapshot<List<Show>> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return ListView.builder(
                controller: _controller,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (index == snapshot.data.length - 1 &&
                      loadingMore == true) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return ShowTile(snapshot.data[index]);
                });
          }),
    );
  }
}
