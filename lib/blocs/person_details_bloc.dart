import 'package:rxdart/rxdart.dart';
import 'package:mazetvapp/managers/api_manager.dart';
import 'package:mazetvapp/model/person_details.dart';

class PersonDetailsBloc {
  PublishSubject<List<PersonDetailsModel>> _personDetailsSubject;
  ApiManager _api = ApiManager();

  Stream<List<PersonDetailsModel>> get personDetailsObservable =>
      _personDetailsSubject.stream;

  List<PersonDetailsModel> details = List();

  PersonDetailsBloc() {
    _personDetailsSubject = new PublishSubject<List<PersonDetailsModel>>();
  }

  Future getActorById(id) async {
    var response = await _api.getPeoplebyId(id);

    details = personDetailsFromJson(response.body);

    _personDetailsSubject.sink.add(details);
  }
}
