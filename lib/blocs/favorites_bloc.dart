import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:mazetvapp/managers/database_manager.dart';
import 'package:mazetvapp/model/show.dart';

class FavoritesBloc {
  PublishSubject<List<Show>> _favoritesSubject;
  DatabaseManager _db = DatabaseManager.instance;

  Stream<List<Show>> get fevoritesObservable => _favoritesSubject.stream;

  List<Show> shows = List();

  FavoritesBloc() {
    _favoritesSubject = new PublishSubject<List<Show>>();
  }

  Future getFavorites() async {
    var res = await _db.getAll('Show');

    shows = showFromJson(json.encode(res));
    shows.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    _favoritesSubject.sink.add(shows);
  }
}
