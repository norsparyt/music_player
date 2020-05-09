import 'package:music_player/music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player_prototype/model/song.dart';
import 'package:music_player_prototype/screens/allSongs.dart';

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  List<SongInfo> son;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  MusicPlayer musicPlayer;
  bool playing = false;

  @override
  void initState() {
    musicPlayer = MusicPlayer();
    super.initState();
    getThat();
    musicPlayer.onIsPlaying = () {
      playing = true;
      print("playing");
    };
    musicPlayer.onIsPaused = () {
      playing = false;
      print("paused");
    };
  }

  getThat() async {
    son = await audioQuery.getSongs();
  }
double pos=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  musicPlayer.onPosition = (double d) {
                    print("on position:$d");
                    setState(() {
                      pos=d;
                    });
                  };
                }),
            IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  if (playing == true)
                    musicPlayer.pause();
                  else
                    musicPlayer.resume();
                })
          ],
        ),
        body: SafeArea(child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 600,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                      onTap: () {
                        print("'tap from$index");
                        print(son[index]);
                        musicPlayer.play(MusicItem(
                            url: son[index].filePath,
                            id: son[index].id.toString(),
                            trackName: son[index].title,
                            artistName: son[index].artist,
                            albumName: son[index].album,
                            duration:
                                Duration(milliseconds: int.parse(son[index].duration))));
                      },
                      child: ListTile(
                        title: Text(son[index].title),
                      ),
                    );
              }
              ),
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width*pos,
              color: Colors.blue,
            )
          ],
        )));
  }
}
