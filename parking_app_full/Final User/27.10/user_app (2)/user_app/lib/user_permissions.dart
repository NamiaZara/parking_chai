import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_app/use_profile.dart';
import 'package:user_app/After_login_dashboard.dart';



final customBackgroundColor = Color(0xFFE7E4E4);

class PermissionPage extends StatefulWidget {
  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  bool locationAccess = false;
  bool notificationAccess = false;
  bool deviceStateAccess = false;
  bool storageAccess = false;

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final locationStatus = await Permission.location.status;
    final notificationStatus = await Permission.notification.status;
    final deviceStatus = await Permission.phone.status;
    final storageStatus = await Permission.storage.status;

    setState(() {
      locationAccess = locationStatus.isGranted;
      notificationAccess = notificationStatus.isGranted;
      deviceStateAccess = deviceStatus.isGranted;
      storageAccess = storageStatus.isGranted;
    });
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      checkPermissions();
    } else {
      // Handle permission denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Permissions'),
      ),
      body: Container(
        color: customBackgroundColor,
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView(
            padding: EdgeInsets.all(50.0),
            children: <Widget>[
              buildPermissionTile(
                Icons.location_on,
                'Location Access',
                'Allow access to your location',
                locationAccess,
                    (value) {
                  setState(() {
                    locationAccess = value;
                    if (value) {
                      requestPermission(Permission.location);
                    }
                  });
                },
              ),
              buildPermissionTile(
                Icons.notifications,
                'Notification Access',
                'Enable notifications',
                notificationAccess,
                    (value) {
                  setState(() {
                    notificationAccess = value;
                    if (value) {
                      // Request notification access permission here
                    }
                  });
                },
              ),
              buildPermissionTile(
                Icons.phone_android,
                'Device State Access',
                'Access device state',
                deviceStateAccess,
                    (value) {
                  setState(() {
                    deviceStateAccess = value;
                    if (value) {
                      // Request device state access permission here
                    }
                  });
                },
              ),
              buildPermissionTile(
                Icons.storage,
                'Storage Access',
                'Access device storage',
                storageAccess,
                    (value) {
                  setState(() {
                    storageAccess = value;
                    if (value) {
                      requestPermission(Permission.storage);
                    }
                  });
                },
              ),
            ],
          ),
        ),
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

  Widget buildPermissionTile(
      IconData icon,
      String title,
      String bottomText,
      bool value,
      Function(bool) onChanged,
      ) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 76.0), // Adjust the left padding here
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              bottomText,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
