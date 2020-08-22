import 'package:flutter/material.dart';
import 'package:kriswonderer/Location.dart';
import 'package:kriswonderer/LocationTile.dart';
class LocationPicker extends StatefulWidget {

  final List<Location> locations;
  final List<Location> fullLocation;

  LocationPicker({
    @required this.fullLocation,
    @required this.locations,
  });
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: widget.locations.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    setState(() {
                      widget.locations.removeAt(index);
                    });
                  },
                  child: LocationTile(
                    locale: widget.locations[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text('Swipe to remove location from your list', style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          )),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: FloatingActionButton(
              heroTag: "btn1",
              child: Icon(Icons.add),
              backgroundColor: Color(0xfffcb130),
              elevation: 5,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => _buildLocationAdder(widget.locations, widget.fullLocation)
                ));
              },
            ),
          ),
          SizedBox(height:30),
        ],
      ),
    );
  }

  Widget _buildLocationAdder(List<dynamic> filtered, List<dynamic> all){
    List<dynamic> leftovers = [];
    for(Location locale in all){
      if(!filtered.contains(locale)){
        leftovers.add(locale);
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Add Locations'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: leftovers.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction){
                    setState(() {
                      filtered.add(leftovers[index]);
                      leftovers.removeAt(index);
                    });
                  },
                  child: LocationTile(
                    locale: leftovers[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Text('Swipe to add location to your list', style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          )),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
