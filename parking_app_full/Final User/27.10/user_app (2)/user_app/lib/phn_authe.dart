import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(home: AnimatedPage()));
}

class AnimatedPage extends StatelessWidget {
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
            SizedBox(height: 20),
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
      duration: Duration(seconds: 2),
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
          fontSize: 80,
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
