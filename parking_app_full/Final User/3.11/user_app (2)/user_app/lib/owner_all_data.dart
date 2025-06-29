import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late List<dynamic> _users;
  late List<dynamic> _filteredUsers;

  @override
  void initState() {
    super.initState();
    _users = [];
    _filteredUsers = [];
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse(parking_owner_getdata));
    if (response.statusCode == 200) {
      setState(() {
        _users = json.decode(response.body) as List<dynamic>;
        _filteredUsers = List.from(_users);
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _users.where((user) {
        final name = user['name'].toLowerCase();
        final address = user['address'].toLowerCase();
        return name.contains(query.toLowerCase()) || address.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Parking Owner List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterUsers,
              decoration: InputDecoration(
                labelText: 'Search by Name or Address',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _filteredUsers.isEmpty
                ? Center(child: Text('No matching users found.'))
                : ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredUsers[index]['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${_filteredUsers[index]['email']}'),
                      Text('Address: ${_filteredUsers[index]['address']}'),
                      Text('Number: ${_filteredUsers[index]['contact_number']}'),
                      Text('Space: ${_filteredUsers[index]['parking_space_number']}'),
                      Text('Per_hr_cost: ${_filteredUsers[index]['per_hour_cost']}'),
                      Text('extra_cost: ${_filteredUsers[index]['extra_cost']}'),
                      // Add more Text widgets for additional information if needed
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
