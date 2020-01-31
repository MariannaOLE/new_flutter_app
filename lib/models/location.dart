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
  final String image;
  final List<LocationFact> facts;

  Location({this.id, this.name, this.url, this.image,this.facts});

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        image = '',
        facts = [];

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> fetchAll() async {
    Map<String, String> requestHeaders = {
       'Accept': 'application/json',
    };

    var uri = Endpoint.uri('/carriers');

    final resp = await http.get(uri.toString(), headers: requestHeaders);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    List<Location> list = new List<Location>();

    Map data = json.decode(resp.body);
    
    for (var jsonItem in data['data']) {
      list.add(Location.fromJson(jsonItem));
    }
    return list;
  }

  static Future<Location> fetchByID(String url) async {
    //var uri = Endpoint.uri('/locations/$id');
    Map<String, String> requestHeaders = {
       'Accept': 'application/json',
    };

    final resp = await http.get(url, headers: requestHeaders);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    final Map<String, dynamic> itemMap = json.decode(resp.body);
    return Location.fromJson(itemMap['data']);
  }

  static Future<Location> fetchAny() async {
    return Location.fetchByID('');
  }
}