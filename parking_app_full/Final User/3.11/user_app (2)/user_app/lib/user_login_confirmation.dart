import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:user_app/After_login_dashboard.dart';
import 'package:user_app/owner_all_data.dart';

class Dashboard_garage_owner extends StatefulWidget {
  final token;
  const Dashboard_garage_owner({@required this.token,Key? key}) : super(key: key);

  @override
  State<Dashboard_garage_owner> createState() => _Dashboard_garage_ownerState();
}

class _Dashboard_garage_ownerState extends State<Dashboard_garage_owner> {

  late String user_email;
  late var name1;
  late var name2;
  late var Phn;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    // Use null-aware operator to handle null case
    name1 = jwtDecodedToken['name1'] ;
    name2 = jwtDecodedToken['name2'] ;
    user_email = jwtDecodedToken['user_email'] ;
    Phn = jwtDecodedToken['Phn'] ;

  }
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Scaffold(
        backgroundColor: customBackgroundColor,
        body:Center(
            child: Column(
                mainAxisAlignment :MainAxisAlignment.center,
                children:[
                  Text('Welcome to পার্কিং চাই', style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center, // Center the content vertically
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                      children: [
                        Text(
                          name1,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30, fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          name2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30, fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Profile Information",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 70,
                    //backgroundImage: NetworkImage(profile['profile_picture']),
                    backgroundImage: AssetImage('assets/dp.png'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center, // Center the content vertically
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                      children: [
                        Icon(
                          Icons.email, // Replace 'your_icon' with the desired icon
                          color: Colors.black, // Set the color of the icon
                          size: 40, // Set the size of the icon
                        ),
                        SizedBox(width: 10), // Add some space between the icon and text
                        Text(
                          user_email,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.black,
                            size: 40,
                          ),
                          SizedBox(width: 10),
                          Text(Phn.toString(), style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          )),
                        ]
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text('NEXT'),
                    onPressed: () {
                      Navigator.push(
                          context,MaterialPageRoute(builder: (contest) =>  user_dashboard()));

                    },
                    style: TextButton.styleFrom(
                      padding:const EdgeInsets.all(15),
                      foregroundColor: Colors.white,
                      backgroundColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                      textStyle: const TextStyle(fontSize: 20),

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text('NEXT2'),
                    onPressed: () {
                      Navigator.push(
                          context,MaterialPageRoute(builder: (contest) =>  UserListScreen()));

                    },
                    style: TextButton.styleFrom(
                      padding:const EdgeInsets.all(15),
                      foregroundColor: Colors.white,
                      backgroundColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                      textStyle: const TextStyle(fontSize: 20),

                    ),
                  )
                ]
            )

        )

    );
  }
}

