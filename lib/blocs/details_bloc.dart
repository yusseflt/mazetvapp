import 'package:rxdart/rxdart.dart';
import 'package:tv_test/managers/api_manager.dart';
import 'package:tv_test/model/embeded.dart';

class DetailsBloc {
  PublishSubject<Map> _detailsSubject;
  ApiManager _api = ApiManager();

  Stream<Map> get detailsObservable => _detailsSubject.stream;

  Map shows = {};

  DetailsBloc() {
    _detailsSubject = new PublishSubject<Map>();
  }

  Future getShowById(id) async {
    var res = await _api.getShowsById(id);

    Embeded embedded = embededFromJson(res.body);
    print(embedded.embedded.seasons);
  }
}
