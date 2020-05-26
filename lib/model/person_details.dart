import 'dart:convert';

import 'package:mazetvapp/model/embeded.dart';

List<PersonDetailsModel> personDetailsFromJson(String str) =>
    List<PersonDetailsModel>.from(
        json.decode(str).map((x) => PersonDetailsModel.fromJson(x)));

String personDetailsToJson(List<PersonDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonDetailsModel {
  bool self;
  bool voice;
  Links links;
  Embedded embedded;

  PersonDetailsModel({
    this.self,
    this.voice,
    this.links,
    this.embedded,
  });

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) =>
      PersonDetailsModel(
        self: json["self"],
        voice: json["voice"],
        links: Links.fromJson(json["_links"]),
        embedded: Embedded.fromJson(json["_embedded"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "voice": voice,
        "_links": links.toJson(),
        "_embedded": embedded.toJson(),
      };
}
