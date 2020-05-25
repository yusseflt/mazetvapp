import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_test/blocs/home_bloc.dart';
import 'package:tv_test/handlers/color_handler.dart';
import 'package:tv_test/model/show.dart';
import 'package:tv_test/widgets/home/featured_banner.dart';
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

            return ListView(
              controller: _controller,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 16),
                      SafeArea(
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                'https://static.tvmaze.com/images/tvm-header-logo.png',
                                height: 60,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'settings');
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Featured',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 120,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: FeaturedBanner(snapshot.data[index]));
                          },
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
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'All Shows',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: colors["red_primary"],
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(children: <Widget>[
                  for (var i = 0; i < snapshot.data.length; i++)
                    i < 3
                        ? Container()
                        : i == snapshot.data.length - 1 && loadingMore == true
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: ShowTile(snapshot.data[i]),
                              )
                ]),
              ],
            );
          }),
    );
  }
}
