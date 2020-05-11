import 'package:flutter/material.dart';
class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  double initial=0.0;
  double percentage=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onPanStart: (DragStartDetails details) {
            initial = details.globalPosition.dx;
          },
          onPanUpdate: (DragUpdateDetails details) {
            double distance = details.globalPosition.dx - initial;
            double percentageAddition = distance / 200;
            setState(() {
              percentage = (percentage + percentageAddition).clamp(0.0, 100.0);
            });
          },
          onPanEnd: (DragEndDetails details) {
            initial = 0.0;
          },
          child: Container(
            color: Colors.blue.shade200.withOpacity(0.7),
            width: MediaQuery.of(context).size.width+0.4,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(color: Colors.red, width: (percentage / 100) * MediaQuery.of(context).size.width)
              ],
            ),
          )),
      ),
    );
  }
}
