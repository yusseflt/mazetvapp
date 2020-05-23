import 'dart:convert';

import 'package:tv_test/model/show.dart';

List<SearchModel> searchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

String searchModelToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchModel {
  double score;
  Show show;

  SearchModel({
    this.score,
    this.show,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        score: json["score"].toDouble(),
        show: Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "show": show.toJson(),
      };
}
