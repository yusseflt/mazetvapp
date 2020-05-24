import 'package:tv_test/handlers/request_handler.dart';

class ApiManager {
  static final BASE_API_URL = "http://api.tvmaze.com";

  Future getShowsByPage(page) async {
    try {
      var res = await RequestHandler.makeGet("$BASE_API_URL/shows?page=$page");
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future getShowsById(id) async {
    try {
      var res = await RequestHandler.makeGet(
          "$BASE_API_URL/shows/$id?embed[]=episodes&embed[]=cast&embed[]=seasons");
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future getInitialPersonData(id) async {
    try {
      var res =
          await RequestHandler.makeGet("$BASE_API_URL/shows/$id?embed[]=cast");
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future getPeoplebyId(id) async {
    try {
      var res = await RequestHandler.makeGet(
          "$BASE_API_URL/people/$id/castcredits?embed=show");
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future searchShow(query) async {
    try {
      var res =
          await RequestHandler.makeGet("$BASE_API_URL/search/shows?q=$query");
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future searchActor(query) async {
    try {
      var res =
          await RequestHandler.makeGet("$BASE_API_URL/search/people?q=$query");
      return res;
    } catch (e) {
      throw e;
    }
  }
}
