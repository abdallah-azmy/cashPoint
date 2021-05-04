//import 'package:ntaqat_edara/src/Network/api_provider.dart';
//import 'package:ntaqat_edara/src/UI/src.UI.MainScreens/Notifications.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/painting.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//class NotificationIcon extends StatefulWidget {
//  final scaffold;
//
//  const NotificationIcon({
//    Key key,
//    this.scaffold,
//  }) : super(key: key);
//
//  @override
//  _NotificationIconState createState() => _NotificationIconState();
//}
//
//class _NotificationIconState extends State<NotificationIcon> {
//  int notificationsNum = 0;
//
//  SharedPreferences _prefs;
//  var apiToken;
//  _getShared() async {
//    _prefs = await SharedPreferences.getInstance();
//    setState(() {
//      apiToken = _prefs.getString("api_token");
//    });
//    print("api_token >>>>> $apiToken");
//    getData();
//  }
//
//  getData() async {
//    await ApiProvider(widget.scaffold, context)
//        .getNotifications(apiToken: apiToken, networkError: false)
//        .then((value) async {
//      if (value.code == 200) {
//        setState(() {
//          notificationsNum = value.data.length;
//        });
//      } else {
//        print('error >>> ' + value.error[0].value);
//      }
//    });
//  }
//
////  @override
////  void initState() {
////    // TODO: implement initState
////    super.initState();
////    Future.delayed(Duration(seconds: 1,milliseconds: 300), () {
////      this._getShared();
////    });
////  }
//
//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//    print("didddddddddddddddddddddddd");
//    Future.delayed(Duration(milliseconds: 300), () {
//      this._getShared();
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: () {
//        Navigator.pushAndRemoveUntil(context,
//            MaterialPageRoute(
//                builder: (_)=> Notifications()
//            ), (route) => false);
//
//      },
//      child: Container(
//        height: 30,
//        width: 30,
//        child: Stack(
//          children: <Widget>[
//            Center(
//                child: Image.asset(
//              "assets/icon/notification.png",
//              color: Colors.black,
//              width: 20,
//              height: 20,
//            )),
//            notificationsNum != 0
//                ? Positioned(
//                    top: 3,
//                    right: 4.0,
//                    child: CircleAvatar(
//                      backgroundColor: Colors.red,
//                      radius: 6,
//                      child: Center(
//                        child: Text(
//                          notificationsNum == 1 ? "1" : "1+",
//                          style: TextStyle(
//                              fontSize: 7,
//                              color: Colors.black,
//                              fontWeight: FontWeight.bold),
//                        ),
//                      ),
//                    ),
//                  )
//                : Container(),
//          ],
//        ),
//      ),
//    );
//  }
//}
