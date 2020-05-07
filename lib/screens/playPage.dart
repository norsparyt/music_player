import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:music_player/music_player.dart';
import 'package:music_player_prototype/data/waves.dart';
import 'package:music_player_prototype/screens/allSongs.dart';

class playPage extends StatefulWidget {
  MusicPlayer musicPlayer;

  playPage(this.musicPlayer);

  @override
  _playPageState createState() => _playPageState(musicPlayer);
}

class _playPageState extends State<playPage> with TickerProviderStateMixin {
  MusicPlayer musicPlayer;
  AnimationController _controller, seeking;

  _playPageState(this.musicPlayer);

  Animation h1, h2, h3, h4, h5, seek;

  @override
  void initState() {
    seeking = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration))
      ..addListener(() {
        setState(() {});
      });
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addListener(() {
            setState(() {});
          });
    print("SONG DURATION:$duration");
    super.initState();
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
    seek = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: seeking,
      curve: Curves.linear,
    ));
    print("SONG IS PLAYING AT:$lastPosition");
    if (flag == 1) {
      _controller.forward();
      _controller.repeat(reverse: true);
    }
    seeking.forward(from: lastPosition);
    if (flag != 1) seeking.stop();
  }

  @override
  void dispose() {
    lastPosition = seek.value;
    print("LAST POSITION:$lastPosition");
    _controller.dispose();
    seeking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade200,
        child: Column(
          children: <Widget>[
            ClayContainer(
              customBorderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(170.0)),
              depth: 40,
              spread: 10,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(170.0)),
                child: Container(
                  height: h * 0.45,
                  width: w * 0.8,
                  foregroundDecoration: BoxDecoration(
                      image:
                          DecorationImage(image: art.image, fit: BoxFit.cover)),
                ),
              ),
            ),
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
                ClayContainer(
                  height: h * 0.07,
                  width: h * 0.07,
                  borderRadius: h * 0.08,
                  child: Icon(Icons.skip_previous, color: secColor, size: 25.0),
                ),
//                Padding(padding: EdgeInsets.all(h*0.02),),
                GestureDetector(
                  onTap: () {
                    lastPosition = seek.value;
                    setState(() {
                      flag *= -1;
                    });
                    (flag == 1) ? musicPlayer.resume() : musicPlayer.pause();
                    stopTheAnim();
                  },
                  child: ClayContainer(
                    height: h * 0.09,
                    width: h * 0.09,
                    borderRadius: h * 0.08,
                    child: Icon((flag == 1) ? Icons.pause : Icons.play_arrow,
                        color: secColor, size: 35.0),
                  ),
                ),
//                Padding(padding: EdgeInsets.all(h*0.02),),
                GestureDetector(
                  onTap: () {},
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
            //OF BUTTONS PLAY PAUSE NEXT
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
                        Container(
//                              height: h*0.15,
                          color: Colors.grey.shade200.withOpacity(0.7),
                          width: w * seek.value,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
            //
          ],
        ),
      ),
    ));
  }

  void stopTheAnim() {
    flag == 1 ? seeking.forward(from: lastPosition) : seeking.stop();
    (flag == 1)
        ? _controller.repeat(reverse: true)
        : _controller.animateTo(0.3,
            curve: Curves.linear, duration: Duration(milliseconds: 400));
  }

  showSeekBar() {}
}
