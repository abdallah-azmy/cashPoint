import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/UI/MainScreens/AddCashier.dart';
import 'package:cashpoint/src/UI/MainWidgets/Cashier_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/MyDrawer.dart';
import 'package:cashpoint/src/UI/MainWidgets/My_Orders_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Notification_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Order_Card_ForStore.dart';
import 'package:cashpoint/src/UI/MainWidgets/Payment_Card.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashpoint/src/LoadingDialog.dart';

class MyCashiers extends StatefulWidget {
  final scaffold;
  final openDrawer;
  MyCashiers({this.scaffold, this.openDrawer});
  @override
  _MyCashiersState createState() => _MyCashiersState();
}

class _MyCashiersState extends State<MyCashiers> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  var cashiers = [];
  var loading ;
  SharedPreferences _prefs;
  var apiToken;
  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
    });
    getData();
//    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_key, context).showLoadingDilaog();
    await ApiProvider(_key, context)
        .getCashiers(apiToken: apiToken,)
        .then((value) async {
      if (value.code == 200) {
//        print('Branches number >>>>> ' + value.data.length.toString());
        setState(() {
          cashiers = value.data;
          cashiers = cashiers.reversed.toList();
          loading = "done";
        });
        Navigator.pop(context);
      } else {
//        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {
          loading = "done";
        });

        LoadingDialog(_key, context).showNotification(value.error[0].value);
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this._getShared();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        key: _key,
        backgroundColor: Color(0xfff5f6f8),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SpecialButton(text: localization.text("add cashier"),onTap: (){

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddCashier(apiToken: apiToken,getData: (){
                          getData();
                        },)));
          }, ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return getData();
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          localization.text("cashier"),
                          style: MyColors.styleBold2,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ))),
                      ],
                    ),
                    SizedBox(height: 15,),
                    loading == null
                        ? Container()
                        :
                    cashiers.length == 0
                        ? Expanded(
                          child: ListView(
                      children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height*.8,
                            child: Center(
                                child: Text(localization.text("There are no payments"))),
                          ),
                      ],
                    ),
                        )
                        : Expanded(
                          child: ListView.builder(shrinkWrap: true,
                      itemBuilder: (context, i) {
                          return  CashierCard(

                              img: cashiers[i].image,
                              cashier:cashiers[i] ,
                              id:  cashiers[i].id,
                              name:  cashiers[i].name,
                              phone:   cashiers[i].phone,
                              description:  cashiers[i].description,
                              apiToken: apiToken,
                              scaffold: _key,
                              getData: () {
                                getData();
                              });

                      },
                      itemCount: cashiers.length,
                    ),
                        ),

                  ],
                )


            ),
          ),
        ),
      ),
    );
  }
}

