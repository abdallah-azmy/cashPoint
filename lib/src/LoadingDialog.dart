import 'package:cached_network_image/cached_network_image.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:cashpoint/src/MyColors.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

import 'UI/MainWidgets/Special_Button.dart';


class LoadingDialog {
  var scafold;
  var context;

  LoadingDialog(this.scafold, this.context);

  showLoadingDilaog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              contentPadding: EdgeInsets.all(0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: Colors.transparent,
              content:
              SpinKitChasingDots(
                color: MyColors.darkRed,
                size: 45.0,
              )
//              BarProgressIndicator(
//                numberOfBars: 4,
//                color: Colors.white,
//                fontSize: 5.0,
//                barSpacing: 2.0,
//                beginTweenValue: 5.0,
//                endTweenValue: 13.0,
//                milliseconds: 200,
//              ),
//              SpinKitSquareCircle(
//                color: Colors.white,
//                size: 50.0,
//                controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
//              )

            ),
          );
        });
  }



  showDoubleNotification(title,msg) {
    scafold.currentState.showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: MyColors.styleBold2white,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5,),
            Text(
              msg,
              style: MyColors.styleBold1white,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 90,)
          ],
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 4),
      ),
    );
  }

  showLoadingDilaogUploadingVideo() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.transparent,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitChasingDots(
                  color: Colors.black,
                  size: 30.0,
                ),
                SizedBox(height: 15,),
                Text("please wait",style: MyColors.styleNormalWhite,
                textAlign: TextAlign.center,)
              ],
            ),
          );
        });
  }



  deleteAlert(String text, function) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.transparent,
            content: Container(
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        text ?? localization.text("_delete"),
                        style: MyColors.styleBold2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SpecialButton(
                            onTap: function,
                            text: localization.text("confirm"),
                            width: 85.0,
                            color: Colors.red,
                            textColor: Colors.white,
                          ),

                          SpecialButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: localization.text("cancel"),
                            width: 85.0,
                            color: Colors.green,
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }



  payByBank(String text, function) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.transparent,
            content: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        text ?? "هل تريد تسجيل الخروج",
                        style: MyColors.styleBold2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SpecialButton(
                            onTap: function,
                            text: localization.text("send"),
                            width: 85.0,
                            color: Colors.green,
                            textColor: Colors.white,
                          ),

                          SpecialButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: localization.text("cancel"),
                            width: 85.0,
                            color: Colors.red,
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }



  logOutAlert(String text, function) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.transparent,
            content: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        text ?? "هل تريد تسجيل الخروج",
                        style: MyColors.styleBold2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SpecialButton(
                            onTap: function,
                            text: localization.text("confirm"),
                            width: 85.0,
                            color: Colors.red,
                            textColor: Colors.white,
                          ),

                          SpecialButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: localization.text("cancel"),
                            width: 85.0,
                            color: Colors.green,
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }

  showPic(String imageUrl) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.transparent,
            content: Container(
//                height: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(crossAxisAlignment: CrossAxisAlignment.end,children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 27,
                              )),
                        ),
                      ],),
                      SizedBox(height: 10,),
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "$imageUrl",
                        placeholder: (context, url) => new Container(
                          height: 50,
                          color: Colors.black,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                )),
          );
        });
  }

  showAlert(String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Positioned(
                left: 30,
                top: 30,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 27,
                      )),
                ),
              ),
              AlertDialog(
                contentPadding: EdgeInsets.all(0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: Colors.transparent,
                content: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: Text(
                        text ?? "no internet",
                        style: MyColors.styleBold2white,
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ],
          );
        });
  }

  showLoadinView() {
    return SpinKitChasingDots(
      color: Colors.black,
      size: 30.0,
    );
  }

  showMapLoadinView() {
    return SpinKitChasingDots(
      color: Colors.black,
      size: 60.0,
    );
  }

  showNotification(msg) {
    scafold.currentState.showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: MyColors.styleBold1white,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
  }

  showHighNotification(msg) {
    scafold.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Text(
            msg,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                // fontFamily: "Tajawal",
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(.5),
        duration: Duration(seconds: 2),
      ),
    );
  }

  alertPopUpDismissible(String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.black,
            content:   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
              child: Text(
                text ?? localization.text("_delete"),
                style: MyColors.styleBold2white,
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }

  alertPopUp(String text) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.black,
            content:   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
              child: Text(
                text ?? localization.text("_delete"),
                style: MyColors.styleBold2white,
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }





  alertPopUpNotification(msg,title) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.black,
            content:   Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: MyColors.styleBold2white,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5,),
                Text(
                  msg,
                  style: MyColors.styleBold1white,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        });
  }


  showBlackNotification(msg) {
   scafold.currentState.showSnackBar(
      SnackBar(
        content: Container(
          height: 30,
          alignment: Alignment.center,
          child: Text(
            msg,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor:Colors.black,
        duration: Duration(seconds: 3),
      ),
    );
  }
}

//
//class BarProgressIndicator extends StatefulWidget {
//  final int numberOfBars;
//  final double fontSize;
//  final double barSpacing;
//  final Color color;
//  final int milliseconds;
//  final double beginTweenValue;
//  final double endTweenValue;
//
//  BarProgressIndicator({
//    this.numberOfBars = 3,
//    this.fontSize = 10.0,
//    this.color = Colors.black,
//    this.barSpacing = 0.0,
//    this.milliseconds = 250,
//    this.beginTweenValue = 5.0,
//    this.endTweenValue = 10.0,
//  });
//
//  _BarProgressIndicatorState createState() => _BarProgressIndicatorState(
//    numberOfBars: this.numberOfBars,
//    fontSize: this.fontSize,
//    color: this.color,
//    barSpacing: this.barSpacing,
//    milliseconds: this.milliseconds,
//    beginTweenValue: this.beginTweenValue,
//    endTweenValue: this.endTweenValue,
//  );
//}
//
//class _BarProgressIndicatorState extends State<BarProgressIndicator>
//    with TickerProviderStateMixin {
//  int numberOfBars;
//  int milliseconds;
//  double fontSize;
//  double barSpacing;
//  Color color;
//  double beginTweenValue;
//  double endTweenValue;
//  List<AnimationController> controllers = new List<AnimationController>();
//  List<Animation<double>> animations = new List<Animation<double>>();
//  List<Widget> _widgets = new List<Widget>();
//
//  _BarProgressIndicatorState({
//    this.numberOfBars,
//    this.fontSize,
//    this.color,
//    this.barSpacing,
//    this.milliseconds,
//    this.beginTweenValue,
//    this.endTweenValue,
//  });
//
//  initState() {
//    super.initState();
//    for (int i = 0; i < numberOfBars; i++) {
//      _addAnimationControllers();
//      _buildAnimations(i);
//      _addListOfDots(i);
//    }
//
//    controllers[0].forward();
//  }
//
//  void _addAnimationControllers() {
//    controllers.add(AnimationController(
//        duration: Duration(milliseconds: milliseconds), vsync: this));
//  }
//
//  void _addListOfDots(int index) {
//    _widgets.add(Padding(
//      padding: EdgeInsets.only(right: barSpacing),
//      child: _AnimatingBar(
//        animation: animations[index],
//        fontSize: fontSize,
//        color: color,
//      ),
//    ));
//  }
//
//  void _buildAnimations(int index) {
//    animations.add(
//        Tween(begin: widget.beginTweenValue, end: widget.endTweenValue)
//            .animate(controllers[index])
//          ..addStatusListener((AnimationStatus status) {
//            if (status == AnimationStatus.completed)
//              controllers[index].reverse();
//            if (index == numberOfBars - 1 &&
//                status == AnimationStatus.dismissed) {
//              controllers[0].forward();
//            }
//            if (animations[index].value > widget.endTweenValue / 2 &&
//                index < numberOfBars - 1) {
//              controllers[index + 1].forward();
//            }
//          }));
//  }
//
//  Widget build(BuildContext context) {
//    return SizedBox(
//      height: 30.0,
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.end,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: _widgets,
//      ),
//    );
//  }
//
//  dispose() {
//    for (int i = 0; i < numberOfBars; i++) controllers[i].dispose();
//    super.dispose();
//  }
//}
//
//class _AnimatingBar extends AnimatedWidget {
//  final Color color;
//  final double fontSize;
//  _AnimatingBar(
//      {Key key, Animation<double> animation, this.color, this.fontSize})
//      : super(key: key, listenable: animation);
//
//  Widget build(BuildContext context) {
//    final Animation<double> animation = listenable;
//    return Container(
//      height: animation.value,
//      decoration: BoxDecoration(
//        shape: BoxShape.rectangle,
//        border: Border.all(color: color),
//        borderRadius: BorderRadius.circular(2.0),
//        color: color,
//      ),
//      width: fontSize,
//    );
//  }
//}