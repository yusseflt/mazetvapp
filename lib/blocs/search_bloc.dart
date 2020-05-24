import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:tv_test/managers/api_manager.dart';
import 'package:tv_test/model/embeded.dart';
import 'package:tv_test/model/search.dart';

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

      print((list[0] as Person).name);
      _searchSubject.sink.add(list);
    } else {
      response = await _api.searchShow(query);

      list = searchModelFromJson(response.body);
      _searchSubject.sink.add(list);
    }
  }
}
