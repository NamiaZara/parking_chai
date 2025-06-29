import 'package:flutter/material.dart';
import 'package:user_app/User_login.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(home: AnimatedPage()));
}

class AnimatedPage extends StatefulWidget {
  @override
  _AnimatedPageState createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  @override
  void initState() {
    super.initState();
    _startNextPageTimer();
  }

  void _startNextPageTimer() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()), // Replace with your next page widget
    );
  }

  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Scaffold(
      backgroundColor: customBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedText(),
            SizedBox(height: 40), // Increased spacing
            AnimatedCar(),
          ],
        ),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child:Center(
        child:Text(
          'Parking Chai',
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kalam',
          ),
        ),
      ),
    );
  }
}

class AnimatedCar extends StatefulWidget {
  @override
  _AnimatedCarState createState() => _AnimatedCarState();
}

class _AnimatedCarState extends State<AnimatedCar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: Offset(1, 0), // Start from the right side
      end: Offset(-1, 0), // Move towards the left
    ).animate(_controller);

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: SvgPicture.asset(
        'assets/car.svg', // Replace with your SVG image path
        width: 50,
        height: 50,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Scaffold(
      backgroundColor: customBackgroundColor,
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/home.png', // Replace with your image asset path
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          // Existing content goes here
          Container(
            padding: EdgeInsets.only(left: 40, top: 130),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Parking Chai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'A Commercial Parking App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 450), // Add spacing
                Center(
                  child:TextButton(
                    child: Text('Get Started'),
                    onPressed: () {
                      Navigator.push(
                          context,MaterialPageRoute(builder: (contest) =>  User_Login()));
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(30),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}