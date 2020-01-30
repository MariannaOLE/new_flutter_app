import 'package:json_annotation/json_annotation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../endpoint.dart';
import './location_fact.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final List<LocationFact> facts;

  Location({this.id, this.name, this.url, this.facts});

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        facts = [];

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/5e32dd1b320000520094d1f2');

    final resp = await http.get(uri.toString());

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    List<Location> list = new List<Location>();
    
    for (var jsonItem in json.decode(resp.body)) {
      list.add(Location.fromJson(jsonItem));
    }
    return list;
  }

  static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/locations/$id');

    final resp = await http.get(uri.toString());

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    final Map<String, dynamic> itemMap = json.decode(resp.body);
    return Location.fromJson(itemMap);
  }

  static Future<Location> fetchAny() async {
    return Location.fetchByID(1);
  }
}