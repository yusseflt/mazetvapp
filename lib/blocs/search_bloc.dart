import 'package:rxdart/rxdart.dart';
import 'package:tv_test/managers/api_manager.dart';
import 'package:tv_test/model/search.dart';
import 'package:tv_test/model/show.dart';

class SearchBloc {
  PublishSubject<List<SearchModel>> _searchSubject;
  ApiManager _api = ApiManager();

  Stream<List<SearchModel>> get searchObservable => _searchSubject.stream;

  List<SearchModel> shows = List();

  SearchBloc() {
    _searchSubject = new PublishSubject<List<SearchModel>>();
  }

  Future searchQuery(query) async {
    var response = await _api.searchQuery(query);

    shows = searchModelFromJson(response.body);
    _searchSubject.sink.add(shows);
  }
}
