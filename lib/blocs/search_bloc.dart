import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:mazetvapp/managers/api_manager.dart';
import 'package:mazetvapp/model/embeded.dart';
import 'package:mazetvapp/model/search.dart';

class SearchBloc {
  PublishSubject<List> _searchSubject;
  ApiManager _api = ApiManager();

  Stream<List> get searchObservable => _searchSubject.stream;

  List list = List();

  SearchBloc() {
    _searchSubject = new PublishSubject<List>();
  }

  Future searchQuery(query, type) async {
    var response;
    if (type == 'people') {
      response = await _api.searchActor(query);

      list = List<Person>.from(
          json.decode(response.body).map((x) => Person.fromJson(x["person"])));

      _searchSubject.sink.add(list);
    } else {
      response = await _api.searchShow(query);

      list = searchModelFromJson(response.body);
      _searchSubject.sink.add(list);
    }
  }
}
