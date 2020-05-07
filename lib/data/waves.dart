import 'package:flutter/material.dart';
import 'package:music_player_prototype/screens/allSongs.dart';

class waves extends CustomPainter {
  double firstH;
  double secondH;
  double thirdH;
  double fourthH;
  double fifthH;
  waves(this.firstH,this.secondH,this.thirdH,this.fourthH,this.fifthH);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = primColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

path.moveTo(0, size.height * 0.5);

path.quadraticBezierTo(size.width * 0.12, size.height * firstH,
size.width * 0.23, size.height * 0.505);//UP

path.quadraticBezierTo(size.width * 0.47, size.height * secondH,
size.width*0.65,size.height*0.49);//DOWN

path.quadraticBezierTo(size.width * 0.78, size.height * thirdH,
size.width * 0.91, size.height * 0.49);//UP

path.quadraticBezierTo(size.width * 0.98, size.height * fourthH,
size.width * 1.0, size.height * fifthH);//DOWN

path.lineTo(size.width, size.height*1.0);
path.lineTo(0, size.height*1.0);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
//  path.moveTo(0, size.height * 0.45);
//  path.quadraticBezierTo(size.width * 0.06, size.height * 0.44,
//  size.width * 0.115, size.height * 0.452);//UP
//
//  path.quadraticBezierTo(size.width * 0.235, size.height * 0.48,
//  size.width*0.325,size.height*0.445);//DOWN
//
//  path.quadraticBezierTo(size.width * 0.39, size.height * 0.42,
//  size.width * 0.455, size.height * 0.445);//UP
//
//  path.quadraticBezierTo(size.width * 0.485, size.height * 0.457,
//  size.width * 0.5, size.height * 0.453);//DOWN
////________________________________________________________________________________________
//
//  path.quadraticBezierTo(size.width * 0.56, size.height * 0.44,
//  size.width * 0.615, size.height * 0.452);//UP
//
//  path.quadraticBezierTo(size.width * 0.735, size.height * 0.48,
//  size.width*0.825,size.height*0.445);//DOWN
//
//  path.quadraticBezierTo(size.width * 0.89, size.height * 0.42,
//  size.width * 0.955, size.height * 0.445);//UP
//
//  path.quadraticBezierTo(size.width * 0.985, size.height * 0.46,
//  size.width * 1.0, size.height * 0.456);//DOWN
//
//  path.lineTo(size.width, size.height*1.0);
//  path.lineTo(0, size.height*1.0);
}
