import 'package:flutter/material.dart';
import 'package:pokemon/consts/consts_app.dart';
import 'package:pokemon/screens/home_screens/widgets/app_bar_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double statusWidht = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(240 / 4.7),
            left: screenWidht - (240 / 1.6),
            child: Opacity(
              child: Image.asset(
                ConstsApp.blackPokeball,
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: statusWidht,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                        ListTile(
                          title: Text("Pokemon"),
                        ),
                      ],
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
