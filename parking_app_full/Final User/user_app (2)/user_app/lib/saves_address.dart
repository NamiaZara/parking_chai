import 'package:flutter/material.dart';
import 'package:user_app/After_login_dashboard.dart';
import 'package:user_app/use_profile.dart';

class SavedAddressPage extends StatefulWidget {
  @override
  _SavedAddressPageState createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Saved Addresses',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Show/hide the search bar
              showSearch(context: context, delegate: _SearchDelegate());
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SavedAddressItem(
            title: 'Home',
            address: '#74/b khilgaon,dhaka-1219',
          ),
          SavedAddressItem(
            title: 'Work',
            address: '456 Office Rd, dhaka',
          ),
          // Add more saved address items here
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,MaterialPageRoute(builder: (contest) =>  user_dashboard()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.map_sharp , color: Colors.white),
                  onPressed: () {
                    // Implement the action for the second icon here
                  },
                ),

                IconButton(
                  icon: Icon(Icons.person_3_sharp , color: Colors.white),
                  onPressed: () {
                    // Implement the action for the fourth icon here
                    Navigator.push(
                        context,MaterialPageRoute(builder: (contest) =>  ProfilePage()));
                  },
                ),
              ],
            ),
            SizedBox(height: 5), // Adjust spacing between icons and text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Home', style: TextStyle(color: Colors.white)),
                Text('Map', style: TextStyle(color: Colors.white)),
                Text('Profile', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SavedAddressItem extends StatelessWidget {
  final String title;
  final String address;

  SavedAddressItem({
    required this.title,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(address),
        onTap: () {
          // Handle tap on saved address item
        },
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Handle delete action
          },
        ),
      ),
    );
  }
}

class _SearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results here
    return Center(
      child: Text('Search results for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions here
    return Center(
      child: Text('Type to search for saved addresses'),
    );
  }
}
