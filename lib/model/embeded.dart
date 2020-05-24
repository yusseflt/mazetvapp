import 'dart:convert';

import 'package:tv_test/model/show.dart';

Embeded embededFromJson(String str) => Embeded.fromJson(json.decode(str));

String embededToJson(Embeded data) => json.encode(data.toJson());

class Embeded {
  Embedded embedded;

  Embeded({
    this.embedded,
  });

  factory Embeded.fromJson(Map<String, dynamic> json) => Embeded(
        embedded: Embedded.fromJson(json["_embedded"]),
      );

  Map<String, dynamic> toJson() => {
        "_embedded": embedded.toJson(),
      };
}

class Embedded {
  List<Episode> episodes;
  List<Cast> cast;
  List<Season> seasons;
  Show show;

  Embedded({
    this.episodes,
    this.cast,
    this.seasons,
    this.show,
  });

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        episodes: json["episodes"] == null
            ? null
            : List<Episode>.from(
                json["episodes"].map((x) => Episode.fromJson(x))),
        cast: json["cast"] == null
            ? null
            : List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        show: json["show"] == null ? null : Show.fromJson(json["show"]),
        seasons: json["seasons"] == null
            ? null
            : List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };
}

class Cast {
  Person person;
  Character character;
  bool self;
  bool voice;

  Cast({
    this.person,
    this.character,
    this.self,
    this.voice,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        person: Person.fromJson(json["person"]),
        character: Character.fromJson(json["character"]),
        self: json["self"],
        voice: json["voice"],
      );

  Map<String, dynamic> toJson() => {
        "person": person.toJson(),
        "character": character.toJson(),
        "self": self,
        "voice": voice,
      };
}

class Character {
  int id;
  String url;
  String name;
  Img image;
  Links links;

  Character({
    this.id,
    this.url,
    this.name,
    this.image,
    this.links,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        image: json["image"] == null ? null : Img.fromJson(json["image"]),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "image": image == null ? null : image.toJson(),
        "_links": links.toJson(),
      };
}

class Links {
  Self self;

  Links({
    this.self,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json == null ? null : Self.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
      };
}

class Self {
  String href;

  Self({
    this.href,
  });

  factory Self.fromJson(Map<String, dynamic> json) => Self(
        href: json == null ? null : json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Person {
  int id;
  String url;
  String name;
  Country country;
  DateTime birthday;
  dynamic deathday;
  String gender;
  Img image;
  Links links;

  Person({
    this.id,
    this.url,
    this.name,
    this.country,
    this.birthday,
    this.deathday,
    this.gender,
    this.image,
    this.links,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        country: Country.fromJson(json["country"]),
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"],
        image: Img.fromJson(json["image"]),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "country": country.toJson(),
        "birthday": birthday == null
            ? null
            : "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "deathday": deathday,
        "gender": gender,
        "image": image.toJson(),
        "_links": links.toJson(),
      };
}

class Country {
  String name;
  Code code;
  Timezone timezone;

  Country({
    this.name,
    this.code,
    this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json == null ? null : json["name"],
        code: json == null ? null : codeValues.map[json["code"]],
        timezone: json == null ? null : timezoneValues.map[json["timezone"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": codeValues.reverse[code],
        "timezone": timezoneValues.reverse[timezone],
      };
}

enum Code { US, CA, GB }

final codeValues = EnumValues({"CA": Code.CA, "GB": Code.GB, "US": Code.US});

enum Timezone { AMERICA_NEW_YORK, AMERICA_HALIFAX, EUROPE_LONDON }

final timezoneValues = EnumValues({
  "America/Halifax": Timezone.AMERICA_HALIFAX,
  "America/New_York": Timezone.AMERICA_NEW_YORK,
  "Europe/London": Timezone.EUROPE_LONDON
});

class Episode {
  int id;
  String url;
  String name;
  int season;
  int number;
  DateTime airdate;
  Airtime airtime;
  DateTime airstamp;
  int runtime;
  Img image;
  String summary;
  Links links;

  Episode({
    this.id,
    this.url,
    this.name,
    this.season,
    this.number,
    this.airdate,
    this.airtime,
    this.airstamp,
    this.runtime,
    this.image,
    this.summary,
    this.links,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        season: json["season"],
        number: json["number"],
        airdate:
            json["airdate"] == '' ? null : DateTime.tryParse(json["airdate"]),
        airtime: airtimeValues.map[json["airtime"]],
        airstamp:
            json["airdate"] == '' ? null : DateTime.tryParse(json["airstamp"]),
        runtime: json["runtime"],
        image: Img.fromJson(json["image"]),
        summary: json["summary"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "season": season,
        "number": number,
        "airdate":
            "${airdate.year.toString().padLeft(4, '0')}-${airdate.month.toString().padLeft(2, '0')}-${airdate.day.toString().padLeft(2, '0')}",
        "airtime": airtimeValues.reverse[airtime],
        "airstamp": airstamp.toIso8601String(),
        "runtime": runtime,
        "image": image.toJson(),
        "summary": summary,
        "_links": links.toJson(),
      };
}

enum Airtime { THE_2200, THE_2100 }

final airtimeValues =
    EnumValues({"21:00": Airtime.THE_2100, "22:00": Airtime.THE_2200});

class Season {
  int id;
  String url;
  int number;
  String name;
  int episodeOrder;
  DateTime premiereDate;
  DateTime endDate;
  Network network;
  dynamic webChannel;
  Img image;
  String summary;
  Links links;

  Season({
    this.id,
    this.url,
    this.number,
    this.name,
    this.episodeOrder,
    this.premiereDate,
    this.endDate,
    this.network,
    this.webChannel,
    this.image,
    this.summary,
    this.links,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        url: json["url"],
        number: json["number"],
        name: json["name"],
        episodeOrder: json["episodeOrder"],
        premiereDate: json["premiereDate"] == null
            ? null
            : DateTime.tryParse(json["premiereDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.tryParse(json["endDate"]),
        network: Network.fromJson(json["network"]),
        webChannel: json["webChannel"],
        image: Img.fromJson(json["image"]),
        summary: json["summary"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "number": number,
        "name": name,
        "episodeOrder": episodeOrder,
        "premiereDate":
            "${premiereDate.year.toString().padLeft(4, '0')}-${premiereDate.month.toString().padLeft(2, '0')}-${premiereDate.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "network": network.toJson(),
        "webChannel": webChannel,
        "image": image.toJson(),
        "summary": summary,
        "_links": links.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
