import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatelessWidget {

  double backgroundOpacity;

  LoadingScreen({this.backgroundOpacity}) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            color: backgroundOpacity!=null?Colors.white.withOpacity(this.backgroundOpacity):Colors.white,
            child: Center(
              child: Animator<double>(
                tweenMap: {
                  "rotateAnim": Tween<double>(begin: 0, end: 2 * pi + pi / 2),
                  "opacityAnim": Tween<double>(begin: 1, end: 0.3),
                },
                duration: Duration(seconds: 1),
                cycles: 0,
                builder: (context, anim, child) => Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Transform.rotate(
                              angle: anim.getAnimation<double>("rotateAnim").value,
                              child: Image.asset(
                                "assets/pokeball.png",
                                height: 100,
                                width: 100,
                              )),
                          Container(
                            margin: EdgeInsets.only(top:10),
                            padding: EdgeInsets.only(top:10),
                            child: Text("Loading...", style: TextStyle(color: Colors.black.withOpacity(anim.getAnimation<double>("opacityAnim").value), fontSize: 20, decoration: TextDecoration.none),),)
                        ]),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
