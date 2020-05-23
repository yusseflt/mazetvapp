import 'package:rxdart/rxdart.dart';
import 'package:tv_test/managers/api_manager.dart';
import 'package:tv_test/model/embeded.dart';

class DetailsBloc {
  PublishSubject<Embedded> _detailsSubject;
  ApiManager _api = ApiManager();

  Stream<Embedded> get detailsObservable => _detailsSubject.stream;

  Map shows = {};

  DetailsBloc() {
    _detailsSubject = new PublishSubject<Embedded>();
  }

  Future getShowById(id) async {
    var res = await _api.getShowsById(id);

    Embeded embedded = embededFromJson(res.body);

    _detailsSubject.sink.add(embedded.embedded);
  }
}
