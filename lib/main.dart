import 'package:flutter/material.dart';
import 'package:pokemon/screens/home_screens/home_screen.dart';
import 'package:pokemon/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
      providers: <SingleChildWidget>[
        Provider<PokeApiStore>(create: (_) => PokeApiStore())
      ],
    );
  }
}
