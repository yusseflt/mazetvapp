import 'package:rxdart/rxdart.dart';
import 'package:tv_test/managers/api_manager.dart';
import 'package:tv_test/model/embeded.dart';

class PeopleBloc {
  PublishSubject<List<Cast>> _peopleSubject;
  ApiManager _api = ApiManager();

  Stream<List<Cast>> get peopleObservable => _peopleSubject.stream;

  List<Cast> cast = List();

  PeopleBloc() {
    _peopleSubject = new PublishSubject<List<Cast>>();
  }

  Future getInitialActors() async {
    cast = List();
    for (int i = 1; i <= 5; i++) {
      var response = await _api.getInitialPersonData(i);

      Embeded e = embededFromJson(response.body);

      cast.addAll(e.embedded.cast);
    }
    _peopleSubject.sink.add(cast);
  }
}
