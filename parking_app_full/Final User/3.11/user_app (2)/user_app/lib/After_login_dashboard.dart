import 'package:flutter/material.dart';
import 'package:user_app/User_login.dart';
import 'package:user_app/saves_address.dart';
import 'package:user_app/user_login_confirmation.dart';
import 'package:user_app/user_permissions.dart';
import 'package:user_app/reqest_send.dart';
import 'package:user_app/search_request.dart';


class user_dashboard extends StatelessWidget {
  //const parking_owner_dashboard({Key? key}) : super(key: key);

  final List<IconData> icons = [
    Icons.search,
    Icons.save,
  ];

  final List<String> labels = [
    'Search',
    'Saved Address',
  ];

  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    Image.asset(
      'assets/home.jpg',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Parking Chai', style: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigator.push(
              //     context,MaterialPageRoute(builder: (contest) =>  ProfilePage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/dp.png'),
                  radius: 30,
                  backgroundColor: customBackgroundColor,

                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Help'),
              onTap: () {
                // Handle drawer item tap for earning info
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Permissions'),
              onTap: () {
                Navigator.push(
                    context,MaterialPageRoute(builder: (contest) =>  PermissionPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Policies'),
              onTap: () {
                // Handle drawer item tap for earning info
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle drawer item tap for settings
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),

          ],
        ),
      ),

      body: Container(
        // decoration: BoxDecoration(
        //   // Add your background image here
        //   image: DecorationImage(
        //     image: AssetImage('assets/car.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child:GridView.builder(
          padding: EdgeInsets.all(20.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return DashboardItem(
              icon: icons[index],
              label: labels[index],
              onTap: () {
                _handleDashboardItemTap(context, labels[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
void _handleDashboardItemTap(BuildContext context, String label) {
  if (label == 'Search') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationSearchScreen()
            //     UserRequestScreen(
            //   userId: '6533beba3399cf4e5d2cc929', // Provide the actual user ID
            //   parkingOwnerId: '648ef8e1ab542be80ff520a8', // Provide the actual parking owner ID
            // ),
          ),
        );
  }
  else if (label == 'Saved Address') {
    // Replace with your DailyDataEntryPage constructor
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SavedAddressPage()),
    );
  }
  // Add similar conditions for other pages
}


void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Out',style: TextStyle(
          color: Colors.black,
        ),),
        content: Text('Are you sure you want to log out?',style: TextStyle(
          color: Colors.black,
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel',style: TextStyle(
              color: Colors.black,
            ),),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,MaterialPageRoute(builder: (contest) =>  User_Login()));
              //(context); // Call your logout function here
            },
            child: Text('Log Out',style: TextStyle(
              color: Colors.black,
            ),),
          ),
        ],
      );
    },
  );
}
class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  DashboardItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: Colors.black),
            SizedBox(height: 10.0),
            Text(label, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}


