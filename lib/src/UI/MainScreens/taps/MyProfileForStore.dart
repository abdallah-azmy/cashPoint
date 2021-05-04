import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/Network/api_provider.dart';

import 'package:cashpoint/src/UI/Authentication/sendingCode.dart';
import 'package:cashpoint/src/UI/MainScreens/MyFatooraWebview.dart';
import 'package:cashpoint/src/UI/MainWidgets/Settings_Row.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Text_Field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileForStore extends StatefulWidget {
  final scaffold;
  MyProfileForStore({
    this.scaffold,
  });
  @override
  _MyProfileForStoreState createState() => _MyProfileForStoreState();
}

class _MyProfileForStoreState extends State<MyProfileForStore> {
  String phone;

  GlobalKey<ScaffoldState> _scafold = new GlobalKey<ScaffoldState>();

  var barCode =
      "https://www.qr-code-generator.com/wp-content/themes/qr/new_structure/markets/core_market_full/generator/dist/generator/assets/images/websiteQRCode_noFrame.png";

  SharedPreferences _prefs;
  var apiToken;
  var logInType;
  var details;
  var detailsOfGeneralData;
  var loading = true;
  var imgFromCach;
  var name;

  _getShared() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = _prefs.getString("api_token");
      logInType = _prefs.getString("login");
      imgFromCach = _prefs.getString("image");
      name = _prefs.getString("name");
      loading = false;
    });
    getData();
//    print("api_token >>>>> $apiToken");
  }

  getData() async {
    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .getMyProfileStore(apiToken: apiToken)
        .then((value) async {
      if (value.code == 200) {
//        print("correct connection");
        setState(() {
          details = value.data[0];
        });
        print(">>>>>>>>>>> ${value.data[0].isPaid}");
//        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);

        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });


    await ApiProvider(_scafold, context)
        .getGeneralData()
        .then((value) async {
      if (value.code == 200) {
        setState(() {
          detailsOfGeneralData = value.data;
        });
        Navigator.pop(context);
      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);
        LoadingDialog(_scafold, context).showNotification(value.error[0].value);
      }
    });
  }
var _image ;

  Future getImage() async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pic;
    });
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
//    uploadPic(context);
  }



  payOffCommission(type, fatoora) async {
    LoadingDialog(_scafold, context).showLoadingDilaog();
    await ApiProvider(_scafold, context)
        .payOffCommission(
        apiToken: apiToken,
        image: _image,
        payment_type: type,
        my_fatoora: fatoora)
        .then((value) async {
      if (value.code == 200) {
        Navigator.pop(context);
        LoadingDialog(_scafold, context).alertPopUp("تمت العملية بنجاح");

        Future.delayed(Duration(milliseconds: 750), () {
          Navigator.pop(context);
          getData().then((anotherValue){

            if(value.data.paymentUrl != null){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OnlinePaymentScreen(
                      url: value.data.paymentUrl,
                    )),
              );
            }
          });
        });

      } else {
        print('error >>> ' + value.error[0].value);
        Navigator.pop(context);

        if(value.error[0].value == "my fatoora لاغٍ"){
          LoadingDialog(_scafold, context).alertPopUp("يرجي المحاولة لاحقا");
        }else{
          LoadingDialog(_scafold, context).alertPopUp(value.error[0].value);
        }

      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getShared();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          key: _scafold,
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xfff5f6f8),
          body: RefreshIndicator(
            onRefresh: (){
              return getData();
            },
            child: SafeArea(
              child: Stack(
                children: <Widget>[
//                Image.asset(
//                  "assets/cashpoint/Nbackground.png",
//                  fit: BoxFit.fill,
//                  width: MediaQuery.of(context).size.width,
//                  height: MediaQuery.of(context).size.height,
//                ),
                  ListView(
                    children: <Widget>[
//
                      Container(
                        decoration: BoxDecoration(color: MyColors.darkRed),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 9, right: 10, left: 10),
                                    child: Text(
                                      localization.text("profile"),
                                      style: MyColors.styleBold2white,
                                    )),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 12,
                                      ),
                                      CachedNetworkImage(
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.fill,
                                        imageUrl:

//                                        details == null
//                                            ? " "
//                                            : details.logo == null
//                                                ? " "
//                                                : "${details.logo}",
                                          "$imgFromCach",
                                        imageBuilder: (context, imageProvider) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10000.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10000.0),
                                                child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            new Container(
                                          height: 80,
                                          width: 80,
//                                      color: MyColors.grey,
                                          child: Center(
                                              child: CircularProgressIndicator()),
                                        ),
                                        placeholderFadeInDuration:
                                            Duration(milliseconds: 500),
                                        errorWidget: (context, url, error) =>  Container(
                                          height: 80,
                                          width: 80,
//                                      color: MyColors.grey,
                                          child: Center(
                                              child:
                                              Icon(Icons.error,color: Colors.white,size: 30,)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "مرحبا",
                                            style: MyColors.styleBold4white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
//                                            details == null
//                                                ? " "
//                                                : details.name == null
//                                                    ? " "
//                                                    : "${details.name}",
                                            name == null ? " " : "$name",
                                            style: MyColors.styleBold4white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 9, right: 10, left: 10),
                                    child: Text(
                                      localization.text("profile"),
                                      style: TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 18,
                                          // fontFamily: "Tajawal",
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 45,
                                child: Center(
                                  child: Column(
                                    children: [
//                                      Text(
//                                        "eslam-yousry@gmail.com",
//                                        style: MyColors.styleBoldOrangeSmall,
//                                      ),
                                      Text(
                                        "${localization.text("Membership No")} ${details == null ? "" : details.membershipNum == null ? "" : "${details.membershipNum}"}",
                                        style: MyColors.styleNormalWhite,
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: MyColors.darkRed,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(80),
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: MyColors.darkRed,
                                  borderRadius: BorderRadius.only(
//                        bottomLeft:  Radius.circular(80),
                                      ),
                                ),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff5f6f8),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(80),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "اجمالي مبيعاتي",
                                      style: MyColors.styleNormal1,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "SR",
                                          style: MyColors.styleBoldOrange,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(  details == null
                                            ? " "
                                            : details.totalSales == null
                                            ? " "
                                            : "${details.totalSales}",),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      "اجمالي عمولات كاش بوينت",
                                      style: MyColors.styleNormal1,
                                    )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "SR",
                                          style: MyColors.styleBoldOrange,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text( details == null
                                            ? " "
                                            : details.totalCommissions == null
                                            ? " "
                                            : "${details.totalCommissions}",),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "عمولة كاش بوينت الحالية",
                                          style: MyColors.styleNormal1,
                                        )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "SR",
                                          style: MyColors.styleBoldOrange,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text( details == null
                                            ? " "
                                            : details.currentCommissions == null
                                            ? " "
                                            : "${details.currentCommissions}",),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),


                      SizedBox(
                        height: 60,
                      ),








                      details == null
                          ? Container()
                          :

                      (details.isPaid == 0)


                          ? Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                          color: Colors.green[900],
                          padding: const EdgeInsets.symmetric(
                              vertical: 10),
                          width:
                          MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Text(
                                "انتظر تاكيد الادارة للدفع",
                                style:
                                MyColors.styleNormalWhite,
                              ),
                              Text(
                                "${details.currentCommissions}",
                                style:
                                MyColors.styleNormalWhite,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      )
                          :


                      details.isPaid == 3 ?
                      Column(
                        children: [
                          Text(
                            "يجب سداد العمولة المستحقة",
                            style:
                            MyColors.styleNormal1,
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SpecialButton(
                              text: "تسديد",
                              onTap: (){

                                chooseFiltrationMethod(context);

                              },
                            ),
                          ),
                        ],
                      )
                          :  details.isPaid == 1 ?

                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Container(
                          color: Colors.green[900],
                          padding: const EdgeInsets.symmetric(
                              vertical: 10),
                          width:
                          MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Text(
                                "تم تأكيد الدفع",
                                style:
                                MyColors.styleNormalWhite,
                              ),
                              Icon(Icons.check_circle,size: 20,color: Colors.white,),

                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ):   details.isPaid == 2 ?

                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.red[900],
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              width:
                              MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Text(
                                    "تم رفض طلب السداد",
                                    style:
                                    MyColors.styleNormalWhite,
                                  ),
//                              Icon(Icons.ch,size: 20,color: Colors.white,),

                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SpecialButton(
                                text: "تسديد",
                                onTap: (){

                                  chooseFiltrationMethod(context);

                                },
                              ),
                            ),
                          ],
                        ),
                      ): details.isPaid == 4  ? Container()  : Container()
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
  chooseFiltrationMethod(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[

                details.onlinePayment == 0 ? Container() :  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);
                      chooseMyFatoora(context);
//                      payOffCommission(1, 1);
                      //مدي واحد
                    },
                    text: "دفع ماي فاتورة",
                  ),
                ),

                details.onlinePayment == 0 ? Container() :    Divider(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);

                      getImage().then((value) async {
                        _image == null
                            ? print("choose the image")
                            : payOffCommission(0, null);
                      });
                    },
                    text: "الدفع البنكي (صورة الوصل)",
                  ),
                ),

                detailsOfGeneralData == null ? Container() :  Column(
                  children: [

                    detailsOfGeneralData.bankName == null ? Container() :
                    Text("${detailsOfGeneralData.bankName}"),

                    SizedBox(
                      height: 3,
                    ),
                    detailsOfGeneralData.bankName == null ? Container() :
                    Text("SA${detailsOfGeneralData.bankAccount}"),

//                          SizedBox(
//                            height: 60,
//                          ),
                  ],
                ),


                SizedBox(
                  height: 20,
                ),
              ]),
            ),
          );
        });
  }


  chooseMyFatoora(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);
                      payOffCommission(1, 0);
                      },
                    text: "دفع بماي فاتورة",
                  ),
                ),

                details.onlinePayment == 0 ? Container() :  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SpecialButton(
                    onTap: () {
                      Navigator.pop(context);
                      payOffCommission(1, 1);
                      //مدي واحد
                    },
                    text: "دفع بمدي",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          );
        });
  }
}
