import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class RequestHandler {
  static Future makeHTTPRequest(Future httpRequest) async {
    final response = await httpRequest;
    if (response.body != null && response.body != '') {
      return response;
    }
    throw 'Não foi possivel fazer chamada';
  }

  static Future makeGet(url) async {
    return makeHTTPRequest(http.get(url));
  }

  static Future makePost(url, body) async {
    return makeHTTPRequest(http.post(url, body: json.encode(body)));
  }

  static Future makePut(url, body) async {
    return makeHTTPRequest(http.put(url, body: json.encode(body)));
  }

  static Future makeDelete(url) async {
    return makeHTTPRequest(http.delete(url));
  }
}
