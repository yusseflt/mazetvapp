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
}
