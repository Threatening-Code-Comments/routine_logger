import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'routine.dart';

void globalDoOnFabClick(State context) {
  context.setState(() {
    //on button click, add routine
    //routines.add(Routine.random());
    routines.add(Routine.random());
    //routines.first.name += 'A';
  });
}

bool debug_enableDropShadow = false;

void globalDoOnFabLongPress(State context) {
  context.setState(() {
    //debug_enableDropShadow = !debug_enableDropShadow;
    debugPaintSizeEnabled = !debugPaintSizeEnabled;
    //routines.clear();
    //Fluttertoast.showToast(msg: 'cleared: )');
  });
}
