import 'package:flutter/material.dart';
import 'models/location.dart';
import 'location_detail.dart';
import 'styles.dart';


class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Locations", style: Styles.navBarTitle)),
      body: ListView.builder(
        itemCount: this.locations.length,
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  loadData() async {
    final locations = await Location.fetchAll();
    if (this.mounted) {
      setState(() {
        this.locations = locations;
      });
    }
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () => _navigateToLocationDetail(context, location.url),
    );
  }

  void _navigateToLocationDetail(BuildContext context, String locationURL) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationDetail(locationURL)));
  }

  Widget _itemThumbnail(Location location) {
    Image image;
    try {
      image = Image.network(location.image, fit: BoxFit.fitWidth);
    } catch (e) {
      print("could not load image ${location.url}");
    }
    return Container(
      constraints: BoxConstraints.tightFor(height: 100.0),
      child: image,
    );
  }

  Widget _itemTitle(Location location) {
    return Text('${location.name}', style: Styles.textDefault);
  }
}