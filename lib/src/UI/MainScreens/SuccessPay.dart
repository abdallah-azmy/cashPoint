import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:cashpoint/src/UI/MainScreens/MainScreen.dart';
//import 'package:tmam/UI/General/Main/Chat/chat_room.dart';
//import 'package:tmam/helpers/sharedPref_helper.dart';
//import 'package:tmam/provider/getAllChatsProvider.dart';

class SuccessPay extends StatefulWidget {
  @override
  _SuccessPayState createState() => _SuccessPayState();
}

class _SuccessPayState extends State<SuccessPay> {
//  @override
//  void initState() {
//    Provider.of<MyChatsProvider>(context, listen: false)
//        .getAllChats(Provider.of<SharedPref>(context, listen: false).token)
//        .then((value) {
//      if (value.data != null) {
//        Future.delayed(Duration(seconds: 2), () {
//          Navigator.pushAndRemoveUntil(
//              context,
//              MaterialPageRoute(
//                  builder: (_) => ChatRoom(
//                    phone: value.data[0].phone,
//                    secondUserID: value.data[0].secondUserId,
//                    uniqueId: value.data[0].orderId,
//                  )),
//                  (route) => false);
//        });
//      }
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainScreen()),
                  (route) => false);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_tAtUrg.json',
                ),
                Text("تمت عملية الدفع بنجاح"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
