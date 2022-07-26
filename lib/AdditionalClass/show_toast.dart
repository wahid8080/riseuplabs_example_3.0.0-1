
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast{
  static void myToast(String message,Color colorCode,int length){
    Fluttertoast.showToast(
        msg: message,
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: colorCode,
        fontSize: 12,
        toastLength: (length>0)?Toast.LENGTH_LONG:Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
    );
  }
}