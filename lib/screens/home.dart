import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:music_player_prototype/screens/allSongs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player_prototype/data/data.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dart_tags/dart_tags.dart';

TagProcessor tp = new TagProcessor();

class home extends StatefulWidget {
  @override
  homeState createState() => homeState();
}

class homeState extends State<home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  static String txt = recentsList[0].text;
  double td = 1.0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    timeDilation = td;
//    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey.shade100, // navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.grey.shade100, // status bar color
    ));
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          leading: Icon(
            Icons.list,
            color: Colors.black87,
          ),
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.adjust),
              onPressed: () {},
              color: Colors.black87,
            )
          ],
          centerTitle: true,
        ),
//        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
            child: Container(
          width: w,
          height: h,
          child: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0))),
                  width: w,
                  height: h,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 50.0, right: 30.0, top: 30.0, bottom: 20.0),
                        child: Text(cardsList[0].title,
                            style: TextStyle(
                                color: Colors.grey.shade100,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w300)),
                      ), //TEXTKEEPLISTENING
                      Container(
                        color: Colors.grey.shade900,
                        height: h * 0.29,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 18.0),
                              padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: _buildCarouselForKeepListening(context),
                            ),
                            //CAROUSEL KEEP LISTENING
                          ],
                        ),
                      ), //CAROUSELSWIPER
                      Divider(
                        color: Colors.grey.shade100,
                      ), //
                      Container(
                        margin: EdgeInsets.only(
                            left: 50.0, right: 30.0, top: 20.0, bottom: 40.0),
                        child: Text(cardsList[1].title,
                            style: TextStyle(
                                color: Colors.grey.shade100,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w100)),
                      ), //TEXTARTISTS
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height: h * 0.3,
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(recentsList[3].imageUrl),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 140.0),
                              child: Text(
                                recentsList[3].text,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 30.0,fontFamily: 'Quicksand'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 50.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Icon(Icons.album),
                                Padding(padding: EdgeInsets.all(7.0),),
                                Text("122",style: TextStyle(fontSize: 20.0),)
                              ],),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height: h * 0.3,
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(recentsList[4].imageUrl),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 140.0),
                              child: Text(
                                recentsList[4].text,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 30.0,fontFamily: 'Quicksand'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 50.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.music_note),
                                  Padding(padding: EdgeInsets.all(7.0),),
                                  Text("122",style: TextStyle(fontSize: 20.0),)
                                ],),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              height: h * 0.3,
                              foregroundDecoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                      AssetImage(recentsList[5].imageUrl),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 140.0),
                              child: Text(
                                recentsList[5].text,
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 30.0,fontFamily: 'Quicksand'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 50.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.inbox),
                                  Padding(padding: EdgeInsets.all(7.0),),
                                  Text("122",style: TextStyle(fontSize: 20.0),)
                                ],),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: h * 0.15,
                        width: w,
                        color: Colors.black87,
                      )
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0))),
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.home,
                                color: Colors.black87,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.black87,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.library_music,
                                color: Colors.black87,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.person,
                                color: Colors.black87,
                              ),
                              onPressed: () {}),
                        ],
                      )), //BOTTOMNAVBAR
                ],
              ), //NAVBAR
            ],
          ),
        )));
  }

  List<Widget> RecentEntries = List<Widget>.generate(
    3,
    (index) => Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: <Widget>[
              Container(
                foregroundDecoration: BoxDecoration(
//              border: Border.all(color: Colors.black,width: 4.0),
                    image: DecorationImage(
                        image: AssetImage(recentsList[index].imageUrl),
                        fit: BoxFit.fill)),
              ),
              Container(
                decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      begin: Alignment.topRight,
//                      end: Alignment.bottomLeft,
//                      colors: [
//                        Colors.black.withOpacity(0.3),
//                        Colors.black87.withOpacity(0.3),
//                        Colors.black54.withOpacity(0.3),
//                        Colors.black38.withOpacity(0.3),
//                      ],
//                      stops: [
//                        0.1,
//                        0.4,
//                        0.6,
//                        0.9
//                      ]),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top:35.0,right: 45.0),
          alignment: Alignment.center,
          child: Text(
            recentsList[index].text,
            style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
        )
      ],
    ),
  );



  Widget _buildCarouselForKeepListening(BuildContext context) {
    return Swiper(
      onTap: (index) {
        _controller.forward();
        if (index == 0) {
          setState(() {
            td = 1.2;
          });
          Navigator.of(context).push(_createRoute());
        }
      },
      curve: Curves.easeOutCirc,
//    layout: SwiperLayout.STACK,
      itemWidth: 300,
      scale: 0.7,
      viewportFraction: 0.7,
      itemCount: RecentEntries.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
          child: RecentEntries[index],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000))
          ..addListener(() {
            setState(() {});
          });
//    _opacityAnimation = Tween(begin: 0.3, end: 0.03).animate(CurvedAnimation(
//      parent: _controller,
//      curve: Curves.decelerate,
//    ));
    crud();
    getSongList();
//    getSingerList();
//    Timer(Duration(seconds: 4), () {
//      getSingersImages();
//    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          allSongs(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -1.0);
        var end = Offset.zero;
        var curve = Curves.easeOutCubic;
        var curveTween = CurveTween(curve: curve);
        var tween = Tween(begin: begin, end: end).chain(curveTween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  //List singerList;
//  final List<Widget> ArtistEntries = List<Widget>.generate(
//    artistsList.length,
//        (index) => Stack(
//      children: <Widget>[
//        ClipRRect(
//          borderRadius: BorderRadius.circular(10.0),
//          child: Container(
//            foregroundDecoration: BoxDecoration(
////              border: Border.all(color: Colors.black,width: 4.0),
//                image: DecorationImage(
//                    image:  AssetImage(recentsList[0].imageUrl),
//                    fit: BoxFit.fill)),
//          ),
//        ),
//        Container(
//          margin: EdgeInsets.all(10.0),
//          alignment: Alignment.bottomLeft,
//          child: Text(
//            artistsList[index].text,
//            style: TextStyle(
//                fontSize: 27.0,
//                fontWeight: FontWeight.w400,
//                color: Colors.white70),
//          ),
//        )
//      ],
//    ),
//  );
//  Future<List> getSingerList() async {
//    singerList = await dbSinger.getAllSingers();
//    return singerList;
//  }

//  Future<void> getSingersImages() async {
////    TagProcessor tp = new TagProcessor();
//    for (int i = 0; i < singerList.length; i++) {
//      Singer singer = Singer.map(singerList[i]);
//      List artistSongs = await audioQuery.getSongsFromArtist(artist: singer.name);
////     print(artistSongs);
//    }
////    File f = new File(singerList[200].filePath);
////    dynamic l = await tp.getTagsFromByteArray(f.readAsBytes());
////    AttachedPicture ap = (l[1].tags['picture']);
////    print(ap.imageData64);
////    Image imag = Image.memory(base64Decode(ap.imageData64));
//
//  }
}
bool musicPlayingIndicator;