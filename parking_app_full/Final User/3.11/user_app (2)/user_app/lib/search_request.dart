import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'location.dart';


class LocationSearchScreen extends StatefulWidget {
  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<ParkingLocation> _locations = [];

  Future<void> _searchLocations(String query) async {
    final response = await http.get(Uri.parse('http://192.168.1.14:3000/user_location?location=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _locations = data.map((location) => ParkingLocation.fromJson(location)).toList();
      });
    } else {
      // Handle error, display an error message, or retry the request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Location...',
          ),
          onChanged: (query) {
            _searchLocations(query);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_locations[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_locations[index].address),
                Text('Contact: ${_locations[index].contactNumber}'),
                Text('Cost per Hour: \$${_locations[index].perHourCost.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LocationSearchScreen()));
