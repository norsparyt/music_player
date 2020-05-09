import 'package:flutter/material.dart';
import 'package:music_player_prototype/data/test.dart';
import 'package:music_player_prototype/screens/home.dart';


void main() {

  return runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    title: 'Music Player',
    theme: ThemeData(
      fontFamily: 'Quicksand',
      primaryColor: Colors.grey.shade100,
      primaryColorDark: Colors.black87
    ),
    home: home(
    ),
  ));
}
