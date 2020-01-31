import 'package:flutter/material.dart';
import 'models/location.dart';
import 'styles.dart';

class LocationDetail extends StatefulWidget {
  final String locationURL;

  LocationDetail(this.locationURL);

  @override
  createState() => _LocationDetailState(this.locationURL);
}

class _LocationDetailState extends State<LocationDetail> {
  final String locationURL;
  Location location = Location.blank();

  _LocationDetailState(this.locationURL);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(location.name, style: Styles.navBarTitle)),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, location),
        )));
  }

  loadData() async {
    final location = await Location.fetchByID(this.locationURL);

    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = List<Widget>();
    result.add(_bannerImage(location.image, 100.0));
    result.addAll(_renderFacts(context, location));
    return result;
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = List<Widget>();
    for (int i = 0; i < location.facts.length; i++) {
      if (location.facts[i].text == null || location.facts[i].text == "") {
        continue;
      }

      result.add(_sectionTitle(location.facts[i].title));
      result.add(_sectionText(location.facts[i].text));
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
        child:
            Text(text, textAlign: TextAlign.left, style: Styles.headerLarge));
  }

  Widget _sectionText(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Text(text, style: Styles.textDefault));
  }

  Widget _bannerImage(String url, double height) {
    Image image;
    try {
      if (url.isNotEmpty) {
        image = Image.network(url, fit: BoxFit.fitWidth);
      }
    } catch (e) {
      print("could not load image $url");
    }
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: image,
    );
  }
}