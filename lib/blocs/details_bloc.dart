import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:sembast/sembast.dart';
import 'package:mazetvapp/managers/api_manager.dart';
import 'package:mazetvapp/managers/database_manager.dart';
import 'package:mazetvapp/model/embeded.dart';
import 'package:mazetvapp/model/show.dart';

class DetailsBloc {
  PublishSubject<Map> _detailsSubject;
  ApiManager _api = ApiManager();
  DatabaseManager _db = DatabaseManager.instance;

  Stream<Map> get detailsObservable => _detailsSubject.stream;

  Embeded embedded;
  bool favorited = false;

  DetailsBloc() {
    _detailsSubject = new PublishSubject<Map>();
  }

  Future getShowById(show) async {
    var res = await _api.getShowsById(show.showId);

    embedded = embededFromJson(res.body);
    verifyFavorite(show);
    _detailsSubject.sink
        .add({"embedded": embedded.embedded, "favorited": favorited});
  }

  Future addToDB(show, favoriteBloc) async {
    var res = await _db.insertIfDoesNotExists(show);
    if (res == false) {
      await _db.delete(show);
      if (favoriteBloc != null) {
        await favoriteBloc.getFavorites();
      }
      favorited = false;
    } else {
      favorited = true;
    }

    _detailsSubject.sink
        .add({"embedded": embedded.embedded, "favorited": favorited});
  }

  Future verifyFavorite(show) async {
    var res = await _db.find('Show', Filter.equals('id', show.showId));

    if (res != null) {
      Show db = Show.fromJson(json.decode(json.encode(res)));
      if (db.showId == show.showId) {
        favorited = true;
      }
    }
    _detailsSubject.sink
        .add({"embedded": embedded.embedded, "favorited": favorited});
  }
}
