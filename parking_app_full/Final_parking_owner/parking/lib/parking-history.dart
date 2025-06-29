import 'config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EntryData {
  final String carNumber;
  final String name;
  final DateTime entryDate;
  final String entryTime;

  EntryData({
    required this.carNumber,
    required this.name,
    required this.entryDate,
    required this.entryTime,
  });
}

class ExitData {
  final String carNumber;
  final DateTime exitDate;
  final String exitTime;

  ExitData({
    required this.carNumber,
    required this.exitDate,
    required this.exitTime,
  });
}

class Scene extends StatefulWidget {
  @override
  _SceneState createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  List<EntryData> entryData = [];
  List<ExitData> exitData = [];

  @override
  void initState() {
    super.initState();
    // Fetch entry and exit data using a single API endpoint.
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(parking_history));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<dynamic> entryJson = data['entryData'];
        final List<dynamic> exitJson = data['exitData'];

        final List<EntryData> entries = entryJson.map((entry) {
          return EntryData(
            carNumber: entry['car_number'],
            name: entry['name'],
            entryDate: DateTime.parse(entry['entry_date']),
            entryTime: entry['entry_time'],
          );
        }).toList();

        final List<ExitData> exits = exitJson.map((exit) {
          return ExitData(
            carNumber: exit['car_number'],
            exitDate: DateTime.parse(exit['exit_date']),
            exitTime: exit['exit_time'],
          );
        }).toList();

        setState(() {
          entryData = entries;
          exitData = exits;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Entry and Exit Data'),
      ),
      body: ListView.builder(
        itemCount: entryData.length,
        itemBuilder: (context, index) {
          final entry = entryData[index];
          final exit = exitData[index];

          final entryDateFormatted =
              "${entry.entryDate.year}-${entry.entryDate.month.toString().padLeft(2, '0')}-${entry.entryDate.day.toString().padLeft(2, '0')}";
          final exitDateFormatted =
              "${exit.exitDate.year}-${exit.exitDate.month.toString().padLeft(2, '0')}-${exit.exitDate.day.toString().padLeft(2, '0')}";

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Entry Data:'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Car Number: ${entry.carNumber}'),
                        Text('Name: ${entry.name}'),
                        Text('Entry Date: $entryDateFormatted'),
                        Text('Entry Time: ${entry.entryTime}'),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ListTile(
                    title: Text('Exit Data:'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Car Number: ${exit.carNumber}'),
                        Text('Exit Date: $exitDateFormatted'),
                        Text('Exit Time: ${exit.exitTime}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
