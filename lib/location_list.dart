import 'package:flutter/material.dart';
import 'models/location.dart';
import 'styles.dart';


class LocationList extends StatelessWidget {
  final List<Location> locations;

  LocationList(this.locations);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("locations", style: Styles.navBarTitle)),
        body: null,
    );
  }
}