// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.channel,
    this.feeds,
  });

  Channel channel;
  List<Feed> feeds;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        channel: Channel.fromJson(json["channel"]),
        feeds: List<Feed>.from(json["feeds"].map((x) => Feed.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel.toJson(),
        "feeds": List<dynamic>.from(feeds.map((x) => x.toJson())),
      };
}

class Channel {
  Channel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
    this.createdAt,
    this.updatedAt,
    this.lastEntryId,
  });

  int id;
  String name;
  String latitude;
  String longitude;
  String field1;
  String field2;
  String field3;
  String field4;
  String field5;
  String field6;
  DateTime createdAt;
  DateTime updatedAt;
  int lastEntryId;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        field1: json["field1"],
        field2: json["field2"],
        field3: json["field3"],
        field4: json["field4"],
        field5: json["field5"],
        field6: json["field6"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        lastEntryId: json["last_entry_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "field1": field1,
        "field2": field2,
        "field3": field3,
        "field4": field4,
        "field5": field5,
        "field6": field6,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "last_entry_id": lastEntryId,
      };
}

class Feed {
  Feed({
    this.createdAt,
    this.entryId,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
  });

  DateTime createdAt;
  int entryId;
  String field1;
  String field2;
  String field3;
  String field4;
  String field5;
  String field6;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field1: json["field1"],
        field2: json["field2"],
        field3: json["field3"],
        field4: json["field4"],
        field5: json["field5"],
        field6: json["field6"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field1": field1,
        "field2": field2,
        "field3": field3,
        "field4": field4,
        "field5": field5,
        "field6": field6,
      };
}
