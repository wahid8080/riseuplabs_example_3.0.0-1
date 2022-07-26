import 'package:flutter/material.dart';

class CustomAnimation{

  static AnimationController? animCartController;
  static Animation<double>? animCard;

  void initAnim({required double begin,required double end,required SingleTickerProviderStateMixin activity,required bool isReverse,required int millisecond}){
    animCartController = AnimationController(vsync: activity,duration: Duration(milliseconds: millisecond),animationBehavior: AnimationBehavior.normal);
    animCard = Tween<double>(begin: begin,end: end).animate(animCartController!)..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        if(isReverse){
          Future.delayed(const Duration(seconds: 6)).then((value){
            animCartController!.reverse();
          });
        }
      }
    });
  }

  void disposeAnim(){
    animCartController!.dispose();
  }
}