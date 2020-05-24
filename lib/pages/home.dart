import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/home_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/widgets/home/search_show.dart';
import 'package:tv_test/widgets/common/show_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = HomeBloc();
  final ScrollController _controller = ScrollController();
  String query;
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

    page = 0;
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

            return Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16),
                  SafeArea(
                    child: CachedNetworkImage(
                      height: 60,
                      imageUrl:
                          'https://static.tvmaze.com/images/tvm-header-logo.png',
                      placeholder: (context, string) => Container(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: colors['dark_primary'],
                        borderRadius: BorderRadius.circular(4.0)),
                    child: InkWell(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchShow(snapshot.data),
                          query: query,
                        );
                      },
                      child: IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: colors['dark_secondary'],
                            ),
                            labelText: 'Search',
                            labelStyle: TextStyle(
                              color: colors['dark_secondary'],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: colors['red_primary'],
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Flexible(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
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
                        }),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
