import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:music_player/music_player.dart';
import 'package:music_player_prototype/data/data.dart';
import 'package:music_player_prototype/data/waves.dart';
import 'package:music_player_prototype/model/song.dart';
import 'package:music_player_prototype/screens/allSongs.dart';

class playPage extends StatefulWidget {
  MusicPlayer musicPlayer;

  playPage(this.musicPlayer);

  @override
  _playPageState createState() => _playPageState(musicPlayer);
}

class _playPageState extends State<playPage> with TickerProviderStateMixin {
  MusicPlayer musicPlayer;
  AnimationController _controller;
  final pageController = PageController(
    initialPage: 1,
  );

  _playPageState(this.musicPlayer);

  Animation h1, h2, h3, h4, h5;
  int currentSongPlayingIndex;
  double pos = 0.0, initial = 0.0, percentage = 0.0;
  List queue;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < myList.length; i++)
      if (myList[i] == true) currentSongPlayingIndex = i;

    musicPlayer.onPosition = (double d) {
      setState(() {
        pos = d;
      });
    };
    musicPlayer.onCompleted=(){
      currentSongPlayingIndex++;
      playTheSong();
    };
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addListener(() {
            setState(() {});
          });
    print("SONG DURATION:$duration");
    h1 = Tween(begin: 0.28, end: 0.73).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    h2 = Tween(begin: 0.86, end: 0.14).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    h3 = Tween(begin: 0.24, end: 0.73).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    h4 = Tween(begin: 0.62, end: 0.37).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    h5 = Tween(begin: 0.6, end: 0.38).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    if (playing == true) {
      _controller.forward();
      _controller.repeat(reverse: true);
    }
    print(songList.length);
    print(currentSongPlayingIndex);
    queue = new List();
    for (int i = currentSongPlayingIndex;
        i < (currentSongPlayingIndex + 50);
        i++) {
      queue.add(songList[i + 1]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarIconBrightness: Brightness.light,
      statusBarColor: primColor, // status bar color
    ));
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade200,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onHorizontalDragUpdate: (e) {
                showQueuePage(context, h, w);
              },
              child: Container(
                height: h * 0.775,
                child: mainPage(h, w),
              ),
            ), //PlayPAge
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    color: Colors.grey.shade200,
                    height: h * 0.18,
                    width: w,
                    child: Stack(
                      children: <Widget>[
                        CustomPaint(
                            size: MediaQuery.of(context).size,
                            painter: waves(h1.value, h2.value, h3.value,
                                h4.value, h5.value)),
                        seekBar(w, context),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          alignment: Alignment.bottomRight,
                          child: Text(
                              (duration / 60000).floor().toString() +
                                  ":" +
                                  ((duration / 1000).round() % 60).toString(),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400)),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                              (pos * duration/60000).floor().toString()+
                                  ":" +
                                  ((pos * duration/1000).round() % 60).toString(),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade700)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ) //SEEKBARWAVES
          ],
        ),
      ),
    ));
  }

  showQueuePage(BuildContext context, double h, double w) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        context: context,
        builder: (context) {
          return queuePage(h, w);
        });
  }

  Widget mainPage(double h, double w) {
    return Column(
      children: <Widget>[
       Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: (){Navigator.of(context).pop();}),
           Container(child: ClayContainer(
             customBorderRadius:
             BorderRadius.vertical(bottom: Radius.circular(170.0)),
             depth: 40,
             spread: 10,
             child: ClipRRect(
               borderRadius: BorderRadius.vertical(bottom: Radius.circular(170.0)),
               child: Container(
                 height: h * 0.45,
                 width: w * 0.8,
                 foregroundDecoration: BoxDecoration(
                     image: DecorationImage(image: art.image, fit: BoxFit.cover)),
               ),
             ),
           ),
           margin: EdgeInsets.only(right: 15.0),)
       ],),
        //ALBUMART
        Padding(
          padding: EdgeInsets.only(top: h * 0.06),
        ),
        Container(
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              playingSong,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secColor,
                fontSize: 30.0,
              ),
              overflow: TextOverflow.ellipsis,
            )),
        //TEXT OF SONG
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 70.0),
            child: Text(playingArtist,
                textAlign: TextAlign.center,
                style: TextStyle(color: secColor, fontSize: 15.0),
                overflow: TextOverflow.ellipsis)),
        //TEXT OF ARTIST
        Padding(
          padding: EdgeInsets.only(top: h * 0.05),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                currentSongPlayingIndex--;
                playTheSong();
              },
              child: ClayContainer(
                height: h * 0.07,
                width: h * 0.07,
                borderRadius: h * 0.08,
                child: Icon(Icons.skip_previous, color: secColor, size: 25.0),
              ),
            ),
//                Padding(padding: EdgeInsets.all(h*0.02),),
            GestureDetector(
              onTap: () {
                (playing == true) ? musicPlayer.pause() : musicPlayer.resume();
                stopTheAnim();
              },
              child: ClayContainer(
                height: h * 0.09,
                width: h * 0.09,
                borderRadius: h * 0.08,
                child: Icon((playing == true) ? Icons.pause : Icons.play_arrow,
                    color: secColor, size: 35.0),
              ),
            ),
//                Padding(padding: EdgeInsets.all(h*0.02),),
            GestureDetector(
              onTap: () {
                currentSongPlayingIndex++;
                playTheSong();
              },
              child: ClayContainer(
                height: h * 0.07,
                width: h * 0.07,
                borderRadius: h * 0.08,
                child: Icon(
                  Icons.skip_next,
                  color: secColor,
                  size: 25.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget queuePage(double h, double w) {
    dynamic temp;
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(30.0),
            child: Text(
              "Queue",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 30.0,
              ),
            )), //QUEUE
        Container(
          color: primColor,
          child: ListTile(
            title: Text(
              playingSong,
              style: TextStyle(color: Colors.grey.shade200),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border(
                    top: BorderSide(color: primColor),
                  )),
              child: ReorderableListView(
                  children: <Widget>[
                    for (int i = 0; i < queue.length; i++) buildQueue(i)
                  ],
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex -= 1;
                      temp = queue.removeAt(oldIndex);
                      queue.insert(newIndex, temp);
                      temp = songList.removeAt(oldIndex);
                      songList.insert(newIndex, temp);
                    });
                  })),
        )
      ],
    );
  }

  void stopTheAnim() {
    (playing != true)
        ? _controller.repeat(reverse: true)
        : _controller.animateTo(0.3,
            curve: Curves.linear, duration: Duration(milliseconds: 400));
  }

  buildQueue(int i) {
    Song song = Song.map(queue[i]);
    return Container(
      key: ValueKey(i),
      color: Colors.grey.shade200,
      padding: EdgeInsets.only(left: 10.0),
      child: ListTile(
        title: Text(
          song.title,
          style: TextStyle(color: primColor),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.format_list_bulleted, color: primColor),
      ),
    );
  }

  playTheSong() {
    Song song = Song.map(songList[currentSongPlayingIndex]);
    setState(() {
      playingArtist = song.artistName;
      playingSong = song.title;
      duration = int.parse(song.duration);
    });
    if (playing == true)
      musicPlayer.play(MusicItem(
          url: song.path,
          id: song.id.toString(),
          trackName: song.title,
          artistName: song.artistName,
          albumName: song.albumName,
          duration: Duration(milliseconds: int.parse(song.duration))));
    else {
      musicPlayer.play(MusicItem(
          url: song.path,
          id: song.id.toString(),
          trackName: song.title,
          artistName: song.artistName,
          albumName: song.albumName,
          duration: Duration(milliseconds: int.parse(song.duration))));
      musicPlayer.pause();
    }
    getArt(song.path);
  }

  Widget seekBar(double w, BuildContext context) {
    return GestureDetector(
        onPanStart: (DragStartDetails details) {
          initial = details.globalPosition.dx;
        },
        onPanUpdate: (DragUpdateDetails details) {
          double distance = details.globalPosition.dx - initial;
          double percentageAddition = distance / 200;
          setState(() {
            percentage = (percentage + percentageAddition).clamp(0.0, 100.0);
            musicPlayer.seek(percentage / 100);
          });
        },
        onPanEnd: (DragEndDetails details) {
          initial = 0.0;
        },
        child: Container(
          color: Colors.transparent,
          width: w + 0.4,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  color: Colors.grey.shade200.withOpacity(0.7), width: pos * w)
            ],
          ),
        ));
  }
}
