import 'package:rxdart/rxdart.dart';
import 'package:tv_test/managers/api_manager.dart';
import 'package:tv_test/model/show.dart';

class HomeBloc {
  PublishSubject<List<Show>> _homeSubject;
  ApiManager _api = ApiManager();

  Stream<List<Show>> get homeObservable => _homeSubject.stream;

  List<Show> shows = List();

  HomeBloc() {
    _homeSubject = new PublishSubject<List<Show>>();
  }

  Future getShows(page) async {
    var response = await _api.getShowsByPage(page);

    List<Show> newShows = showFromJson(response.body);

    shows = shows + newShows;
    _homeSubject.sink.add(shows);
  }
}
