import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void main() => runApp(MaterialApp(home: UserListScreen()));

class UserListScreen extends StatelessWidget {
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(parking_owner_getdata));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Parking Owner List'),
      ),
      body: FutureBuilder(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            List<dynamic> users = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${users[index]['email']}'),
                      Text('Address: ${users[index]['address']}'),
                      Text('Number: ${users[index]['contact_number']}'),
                      Text('Space: ${users[index]['parking_space_number']}'),
                      Text('Per_hr_cost: ${users[index]['per_hour_cost']}'),
                      Text('extra_cost: ${users[index]['extra_cost']}'),
                      // Add more Text widgets for additional information if needed
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
