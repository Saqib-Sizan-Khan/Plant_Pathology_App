import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:core';
import 'camera_screen.dart';
import 'rounded_button.dart';
import 'gallery_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.yellowAccent, end: Colors.orange)
        .animate(controller);

    controller.forward();

    animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      } else if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      }
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 55.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset('images/applogo.png'),
                    height: 150.0,
                    width: 300.0,
                  ),
                  SizedBox(
                    width: 250.0,
                    child: TextLiquidFill(
                      text: 'Plant Pathology',
                      textAlign: TextAlign.center,
                      waveColor: Colors.green,
                      boxBackgroundColor: animation.value,
                      textStyle: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                      boxHeight: 200.0,
                    ),
                  )
                ],
              ),
              RoundedButton(
                title: 'Capture Image',
                color: Colors.purple,
                onPressed: () {
                  // Navigator.push(context, '/camera');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CameraScreen();
                      },
                    ),
                  );
                },
              ),
              RoundedButton(
                title: 'Choose From Gallery',
                color: Colors.deepPurple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GalleryScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
