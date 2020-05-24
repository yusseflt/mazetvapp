import 'dart:convert';

import 'package:tv_test/model/persistent_object.dart';

List<Show> showFromJson(String str) =>
    List<Show>.from(json.decode(str).map((x) => Show.fromJson(x)));

String showToJson(List<Show> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Show extends PersistentObject {
  int showId;
  String url;
  String name;
  String type;
  String language;
  List<String> genres;
  String status;
  int runtime;
  DateTime premiered;
  String officialSite;
  Schedule schedule;
  Rating rating;
  int weight;
  Network network;
  Network webChannel;
  Externals externals;
  Img image;
  String summary;
  int updated;
  Links links;

  Show({
    this.showId,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.premiered,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.webChannel,
    this.externals,
    this.image,
    this.summary,
    this.updated,
    this.links,
  }) : super('Show');

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        showId: json["id"],
        url: json["url"],
        name: json["name"],
        type: json["type"],
        language: json["language"],
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"].map((x) => x)),
        status: json["status"],
        runtime: json["runtime"],
        premiered: json["premiered"] == null
            ? null
            : DateTime.tryParse(json["premiered"]),
        officialSite: json["officialSite"],
        schedule: Schedule.fromJson(json["schedule"]),
        rating: Rating.fromJson(json["rating"]),
        weight: json["weight"],
        network:
            json["network"] != null ? Network.fromJson(json["network"]) : null,
        webChannel: Network.fromJson(json["webChannel"]),
        externals: Externals.fromJson(json["externals"]),
        image: Img.fromJson(json["image"]),
        summary: json["summary"],
        updated: json["updated"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": showId,
        "url": url,
        "name": name,
        "type": type,
        "language": language,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "status": status,
        "runtime": runtime,
        "premiered":
            "${premiered.year.toString().padLeft(4, '0')}-${premiered.month.toString().padLeft(2, '0')}-${premiered.day.toString().padLeft(2, '0')}",
        "officialSite": officialSite,
        "schedule": schedule.toJson(),
        "rating": rating.toJson(),
        "weight": weight,
        "network": network.toJson(),
        "webChannel": webChannel.toJson(),
        "externals": externals.toJson(),
        "image": image.toJson(),
        "summary": summary,
        "updated": updated,
        "_links": links.toJson(),
      };
}

class Externals {
  int tvrage;
  int thetvdb;
  String imdb;

  Externals({
    this.tvrage,
    this.thetvdb,
    this.imdb,
  });

  factory Externals.fromJson(Map<String, dynamic> json) => Externals(
        tvrage: json == null ? null : json["tvrage"],
        thetvdb: json == null ? null : json["thetvdb"],
        imdb: json == null ? null : json["imdb"],
      );

  Map<String, dynamic> toJson() => {
        "tvrage": tvrage,
        "thetvdb": thetvdb,
        "imdb": imdb,
      };
}

class Img {
  String medium;
  String original;

  Img({
    this.medium,
    this.original,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
        medium: json == null ? null : json["medium"],
        original: json == null ? null : json["original"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "original": original,
      };
}

class Links {
  Previousepisode self;
  Previousepisode previousepisode;

  Links({
    this.self,
    this.previousepisode,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json == null ? null : Previousepisode.fromJson(json["self"]),
        previousepisode: json == null
            ? null
            : Previousepisode.fromJson(json["previousepisode"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
        "previousepisode": previousepisode.toJson(),
      };
}

class Previousepisode {
  String href;

  Previousepisode({
    this.href,
  });

  factory Previousepisode.fromJson(Map<String, dynamic> json) =>
      Previousepisode(
        href: json == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Network {
  int id;
  String name;
  Country country;

  Network({
    this.id,
    this.name,
    this.country,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json == null ? null : json["id"],
        name: json == null ? null : json["name"],
        country: json == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country == null ? null : country.toJson(),
      };
}

class Country {
  String name;
  String code;
  String timezone;

  Country({
    this.name,
    this.code,
    this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json == null ? null : json["name"],
        code: json == null ? null : json["code"],
        timezone: json == null ? null : json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "timezone": timezone,
      };
}

class Rating {
  dynamic average;

  Rating({
    this.average,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json == null ? null : json["average"],
      );

  Map<String, dynamic> toJson() => {
        "average": average,
      };
}

class Schedule {
  String time;
  List<String> days;

  Schedule({
    this.time,
    this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        time: json == null ? null : json["time"],
        days:
            json == null ? null : List<String>.from(json["days"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "days": List<dynamic>.from(days.map((x) => x)),
      };
}
