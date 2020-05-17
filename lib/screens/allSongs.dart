import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:music_player/music_player.dart';
import 'package:music_player_prototype/screens/home.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:music_player_prototype/data/data.dart';
import 'package:music_player_prototype/data/CurvePainter.dart';
import 'package:music_player_prototype/model/song.dart';
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:music_player_prototype/screens/playPage.dart';
import 'package:palette_generator/palette_generator.dart';

class allSongs extends StatefulWidget {
  @override
  _allSongsState createState() => _allSongsState();
}

class _allSongsState extends State<allSongs> with TickerProviderStateMixin {
  MusicPlayer musicPlayer;
  ScrollController _scrollController = ScrollController();
  AnimationController _controller2, _controller1, control;
  Animation appearingAnimation,
      listAnimation,
      scale,
      expand,
      albumart,
      name,
      container;

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _scrollController.dispose();
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarIconBrightness: Brightness.light,
      statusBarColor: primColor, // status bar color
    ));

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              child: DraggableScrollbar.semicircle(
                backgroundColor: Colors.black87,
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      titleSpacing: 35.0,
                      elevation: 0.0,
                      actions: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shuffle),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 33.0),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 170.0),
                        ),
                      ],

                      expandedHeight: MediaQuery.of(context).size.height * 0.45,
                      floating: false,
                      pinned: true,
                      flexibleSpace: allSongsAppbar(),
//                        allSongsDelegate(context)
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (
                          context,
                          index,
                        ) {
                          _controller2.forward();
                          _controller1.forward();
                          try {
                            if (_scrollController.offset <=
                                    _scrollController
                                        .position.minScrollExtent &&
                                !_scrollController.position.outOfRange) {
                              _controller1.reverse();
                            }
                          } catch (e) {}

                          Song song = Song.map(songList[index]);
                          return Container(
                            decoration: BoxDecoration(
                                color: (myList[index] == true)
                                    ? primColor.withOpacity(0.2)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              onTap: () {
                                doSomeWork(song, index);
                              },
                              title: Text(
                                song.title,
                                style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(listAnimation.value)),
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.album,
                                    color: (paletteApplied == true)
                                        ? primColor
                                        : Colors.white,
                                  )),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: IconButton(
                                  icon: Icon(Icons.more_vert),
                                  color: primColor,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return dialogBox(index);
                                        });
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: count,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[showBottomBar()],
            ), //BOTTOMNAVBAR
          ],
        )));
  }

  Widget buildOverlay(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Container(
        margin: EdgeInsets.only(top: 145.0, left: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "All Tracks",
              style: TextStyle(
                  letterSpacing: 0.0,
                  fontSize: 30.0,
                  color: Colors.black87.withOpacity(appearingAnimation.value),
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w200),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
            ),
            Row(
              children: <Widget>[
                Icon(
                  LineAwesomeIcons.music,
                  color: Colors.black54.withOpacity(appearingAnimation.value),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Text(
                  "$count ",
                  style: TextStyle(
                      color:
                          Colors.black54.withOpacity(appearingAnimation.value),
                      fontSize: 20.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  LineAwesomeIcons.clock_o,
                  color: Colors.black54.withOpacity(appearingAnimation.value),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Text(
                  "22 h",
                  style: TextStyle(
                      color:
                          Colors.black54.withOpacity(appearingAnimation.value),
                      fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogBox(int index) {
    return Dialog(
      elevation: 0.0,
        backgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               boxes("Enqueue",Icons.queue_play_next,index),
               Padding(padding: EdgeInsets.only(left: 20.0),),
               boxes("Fav this one", Icons.favorite_border,index),],),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               boxes("Add to Playlist", Icons.playlist_add,index),
               Padding(padding: EdgeInsets.only(left: 20.0),),
               boxes("About Track", Icons.info_outline,index),],)
            ],
          ),
        ));
  }
double spread=1;
  Widget boxes(String text, IconData icon,int index) {
    return GestureDetector(
      onTap: (){
        setState(() {
          spread=0;
        });
        switch(text){
          case "Enqueue":
            if(currentPlayingIndex!=null)
              print("Enqueue");
            break;
            case "Fav this one":
            print("Fav this one");
            break;
          case"Add to Playlist":
            print("Add to Playlist");
            break;
          case"About Track":
            print("About Track");
            break;
        }
      },
      child: ClayContainer(
            borderRadius: 10.0,
            emboss: true,
              spread: spread,
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(icon,color: primColor,),
                ],
              )),
    );

  }

  @override
  void initState() {
    super.initState();
    initialiseValuesForBottomBar();
    musicPlayer = MusicPlayer();
    _controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {});
          });
    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..addListener(() {
            setState(() {});
          });
    listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    ));
    appearingAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeIn,
    ));
    _scrollController.addListener(_scrollListener);
    shouldDisplayBottomBar();
  }
int currentPlayingIndex;
  doSomeWork(Song song, int index) {
    currentPlayingIndex=index;
    getArt(song.path); //1:GET COVER ART AND GET PALETTE COLORS
    musicPlayer.onIsPlaying = () {
      setState(() {
        playing = true;
      });
      print("playing");
    };
    musicPlayer.onIsPaused = () {
      setState(() {
        playing = false;
      });
      print("paused");
    };
    if (tap == true) {
      control.animateBack(0.4, duration: Duration(milliseconds: 200));
      Timer(Duration(milliseconds: 200), () {
        control.forward(from: 0.4);
      });
      setState(() {
        playingArtist = song.artistName;
        playingSong = song.title;
        duration = int.parse(song.duration);
      });
    } else
      Timer(Duration(seconds: 1), () {
        control.forward();
        setState(() {
          playingArtist = song.artistName;
          playingSong = song.title;
          duration = int.parse(song.duration);
        });
      });
    tap = true;
    print("tap from $index");
    resetMyList();

    setState(() {
      myList[index] = true;
    });
    musicPlayer.play(MusicItem(
        url: song.path,
        id: song.id.toString(),
        trackName: song.title,
        artistName: song.artistName,
        albumName: song.albumName,
        duration: Duration(milliseconds: int.parse(song.duration))));
  }

  updatePalettes() async {
    paletteApplied = true;
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      art.image,
    );
    color = (generator.dominantColor);
    if (generator.darkVibrantColor != null)
      color2 = generator.darkVibrantColor;
    else
      color2 = generator.dominantColor;
    setState(() {
      primColor = color.color;
      secColor = color2.color;
    });
  }

  Widget allSongsAppbar() {
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(recentsList[0].imageUrl),
                  fit: BoxFit.cover)),
        ), //IMAGE
        Container(
          child: CustomPaint(
              size: MediaQuery.of(context).size, painter: CurvePainter()),
        ), //CUSTOMPAINTER
        buildOverlay(context),
      ],
    );
  }

  _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("reach the top");
      _controller1.reverse();
    }
  }

  void resetMyList() {
    for (int i = 0; i < count; i++) myList[i] = false;
  }

  Widget showBottomBar() {
    if (tap == true)
      return Transform.scale(
        scale: scale.value,
        child: GestureDetector(
          onTap: () {
            print("GOING TO PLAY PAGE>>>>>>");
            Navigator.of(context).push(_createRouteToPlay());
            updatePalettes();
          },
          child: Container(
            //MAINBAR
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
                color: secColor,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.08)),
            width: expand.value,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                ),
                Transform.scale(
                  scale: albumart.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.065,
                      width: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      foregroundDecoration: BoxDecoration(
//              border: Border.all(color: Colors.black,width: 4.0),
                          image: DecorationImage(
                              image: art.image, fit: BoxFit.fill)),
                    ),
                  ),
                ), //ALBUMART
                Container(
                  width: container.value,
                  padding: EdgeInsets.only(left: 30.0, bottom: 10.0, top: 5.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              playingSong,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey.shade100
                                    .withOpacity(name.value),
                                fontSize: 20.0,
                                wordSpacing: 2.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                            Text(playingArtist,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey.shade100
                                        .withOpacity(name.value),
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w100))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.0),
                      ),
                      Transform.scale(
                          scale: name.value,
                          child: IconButton(
                              icon: Icon(
                                  (playing == true)
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.grey.shade100,
                                  size: 30.0),
                              onPressed: () {
                                if (playing == true)
                                  musicPlayer.pause();
                                else
                                  musicPlayer.resume();
                              })) //PLAYICON
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    else
      return Container(
        height: 0.0,
        width: 0.0,
      );
  }

  Route _createRouteToPlay() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          playPage(musicPlayer),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeOut;
        var curveTween = CurveTween(curve: curve);
        var tween = Tween(begin: begin, end: end).chain(curveTween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  bool paletteApplied = false;

  void initialiseValuesForBottomBar() {
    tap = false;
    control =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            setState(() {});
          });
    scale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: control,
      curve: Interval(0.0, 0.3, curve: Curves.easeIn),
    ));
    expand = Tween(begin: 70.0, end: 400.0).animate(CurvedAnimation(
      parent: control,
      curve: Interval(0.3, 0.6, curve: Curves.easeIn),
    ));
    albumart = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: control,
      curve: Interval(0.4, 0.7, curve: Curves.easeIn),
    ));
    name = Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
      parent: control,
      curve: Interval(0.5, 1.0, curve: Curves.easeIn),
    ));
    container = Tween(begin: 0.0, end: 320.0).animate(CurvedAnimation(
      parent: control,
      curve: Interval(0.6, 0.601, curve: Curves.easeIn),
    ));
  }

  void shouldDisplayBottomBar() {
    if (duration != 0) {
      musicPlayer.onIsPlaying = () {
        setState(() {
          playing = true;
        });
        print("playing");
      };
      musicPlayer.onIsPaused = () {
        setState(() {
          playing = false;
        });
        print("paused");
      };
      control.forward();
      paletteApplied = true;
      tap = true;
      resetMyList();
    }
  }
}

getArt(String path) {
  tp.getTagsFromByteArray(File(path).readAsBytes()).then((l) {
    if ((l[1].tags['picture']) != null) {
      String str = ((l[1].tags['picture']).imageData64);
      art = Image.memory(base64Decode(str));
    } else {
      print("noooo");
      art = img;
    }
  });
//    Timer(Duration(seconds: 2), () {

//    });
}

getSongList() async {
  songList = await db.getAllSongs();
  for (int i = 0; i < songList.length; i++) {
    myList[i] = false;
  }
}

bool tap = false;
List songList;
String playingSong = "";
String playingArtist = "";
Image art = img;
Color secColor = Colors.black87;
Color primColor = Colors.black;
bool playing = false;
int duration = 0;
PaletteColor color;
PaletteColor color2;
