import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'human.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main.dart';
import 'computer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstScreen> {
  static var myNewFont = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.mcLaren(
      textStyle: TextStyle(color: Colors.amber, letterSpacing: 5));
  @override
  Widget build(BuildContext context) {
    final color = Colors.amber;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.brown,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: AvatarGlow(
                      endRadius: 140,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.amber,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 1),
                      startDelay: Duration(seconds: 1),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              style: BorderStyle.none,
                            ),
                            shape: BoxShape.rectangle),
                        child: CircleAvatar(
                          backgroundColor: Colors.brown,
                          child: Container(
                            child: Image.asset(
                              'lib/images/tickii.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          radius: 100.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 40.0,
                        color: Colors.black87,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('TIC TAC TOE'),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Human()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        color: Colors.brown[400],
                        child: SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.amber,
                              shadows: [
                                Shadow(
                                  blurRadius: 7.0,
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FlickerAnimatedText('  v/s Human'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ComputerPage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        color: Colors.brown[400],
                        child: SizedBox(
                          width: 250.0,
                          height: 50.0,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.amber,
                              shadows: [
                                Shadow(
                                  blurRadius: 7.0,
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                FlickerAnimatedText('v/s Computer'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
