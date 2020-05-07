import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  List<SongInfo> son;
  String path;
  Image i;
  songs() async {
    Directory tempDir = await getTemporaryDirectory();
    path = join(tempDir.path, "albums/2904.jpg");
    File img= File(path);
     i= Image.file(img);

    //    son = await audioQuery.getSongs();
//    for (int i = 0; i < son.length; i++)
//      print(son[i].albumId);
//    return path;
  }

  @override
  void initState() {
    super.initState();
    songs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child:Container(
          child: Image(image:i.image),
        )
//    FutureBuilder(
//      future: songs(),
//        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//      if (snapshot.hasData)
//        return Image.file(File(snapshot.data));
//      else
//        return CircularProgressIndicator();
//    })
    ));
  }
}
