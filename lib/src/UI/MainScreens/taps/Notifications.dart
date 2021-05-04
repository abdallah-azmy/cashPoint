import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/Authentication/login.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/UI/MainWidgets/Notification_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';

class Notifications extends StatefulWidget {
  final scaffold;
  final openDrawer;
//  Notifications({this.scaffold, this.openDrawer});
  Notifications({Key key,this.scaffold, this.openDrawer}) : super(key: key);
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var loadingToken = true;
  var loading ;
  var _notifications = [];

  SharedPreferences _prefs;
  var apiToken;
  getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      loadingToken = false;
    });
//    print("api_token >>>>> $apiToken");
    apiToken == null
        ? print("no token")
        : getData();
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getNotifications(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.length.toString());
        setState(() {
          _notifications = value.data;
          loading = "done";
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        setState(() {
          loading = "done";
        });
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }


  deleteNotification(notification_id) async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .deleteNotification(apiToken: apiToken,notification_id: notification_id )
        .then((value) async {
      if (value.code == 200) {
        print('Branches number >>>>> ' + value.data.length.toString());
        Navigator.pop(context);
        LoadingDialog(_key, context).alertPopUp(localization.text("deleted_successfully"));
        Future.delayed(Duration(seconds: 1,milliseconds: 100),(){
          Navigator.pop(context);
          getData();
        });

      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
//        LoadingDialog(_key, context).showNotification(value.error[0].value);
        LoadingDialog(_key, context).alertPopUp(value.error[0].value);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this.getShared();
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadingToken == true
        ? Container()
        :  apiToken == null
        ?
    LoginPage()
//    Scaffold(
////                appBar: AppBar(
////                  automaticallyImplyLeading: false,
////                  backgroundColor: MyColors.darkRed,
////                  centerTitle: true,
////                  elevation: 0,
////                  leading: SizedBox(
////                    width: 20,
////                  ),
////                ),
//      body: Container(
//        height: MediaQuery.of(context).size.height,
//        width: MediaQuery.of(context).size.width,
//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                "يجب تسجيل الدخول اولا",
//                style: MyColors.styleBold2,
//              ),
//              SizedBox(
//                height: 15,
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 70),
//                child: SpecialButton(
//                  text: localization.text("login"),
//                  color: MyColors.darkRed,
//                  height: 35.0,
//                  width: 150.0,
//                  onTap: () {
//                    Navigator.pushAndRemoveUntil(
//                        context,
//                        MaterialPageRoute(
//                            builder: (_) => LoginPage()),
//                            (route) => false);
//                  },
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    )
        :
    Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        key: _key,
        backgroundColor: Color(0xfff5f6f8),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          localization.text("_notifications"),
                          style: MyColors.styleBold2,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    loading == null ? Container() :   _notifications.length == 0
                            ? Expanded(
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .8,
                                      child: Center(
                                          child: Text(localization
                                              .text("no_notifications"))),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => OrderDetails(
//                                    order: myOrders[0].status,
//                                status: myOrders[0],
//
//                                  )),
//                        );

//                                getOrderDetails(_notifications[i].orderId);
                                      },
                                      child: Stack(
                                        children: [
                                          NotificationCard(
                                              time: _notifications[i]
                                                  .totalDuration,
//                                          read: _notifications[i]["read"],
                                              content:
                                                  _notifications[i].description,
                                              title: _notifications[i].title,
                                              id: _notifications[i].id,
                                              apiToken: apiToken,
                                              scaffold: _key,
                                              getData: () {
                                                getData();
                                              }),
                                          Positioned(
                                            child: InkWell(
                                              onTap: () {
                                                LoadingDialog(_key, context)
                                                    .deleteAlert(null, () {
                                                      Navigator.pop(context) ;
                                                  deleteNotification(_notifications[i].id);
                                                });
                                              },
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.cancel)),
                                            ),
                                            left: 0,
                                            top: 0,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: _notifications.length,
                                ),
                              ),
                    SizedBox(
                      height: 75,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
