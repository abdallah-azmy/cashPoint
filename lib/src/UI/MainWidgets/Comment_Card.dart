import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class CommentCard extends StatefulWidget {
  final time;
  final userName;
  final comment;
  final img;

  final onTap;
  final id;
  final apiToken;
  final categoryId;
  final scaffold;
  final getData;

  const CommentCard(
      {Key key,
      this.apiToken,
      this.scaffold,
      this.img,
      this.onTap,
      this.comment,
      this.categoryId,
      this.time,
      this.userName,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  deleteNotification() async {
//    Navigator.pop(context);
//    LoadingDialog(widget.scaffold,context).showLoadingDilaog();
//    await ApiProvider(widget.scaffold, context)
//        .deleteNotification(apiToken: widget.apiToken,notification_id: widget.id)
//        .then((value) async {
//      if (value.code == 200) {
//
//
//        Navigator.pop(context);
//        LoadingDialog(widget.scaffold,context)
//            .showNotification(localization.text("notification_deleted"));
//
//        widget.getData();
//
//
//      } else {
//        print('error >>> ' + value.error[0].value);
//        Navigator.pop(context);
//        Navigator.pop(context);
//
//        LoadingDialog(widget.scaffold,context).showNotification(value.error[0].value);
//      }
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Material(
          elevation: 4,

          borderRadius: BorderRadius.circular(11),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: MediaQuery.of(context).size.width * .8,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(11)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CachedNetworkImage(
                  imageBuilder: (context, provider) {
                    return Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: provider, fit: BoxFit.fill)));
                  },
                  fit: BoxFit.fill,
                  imageUrl: "${widget.img}",
                  placeholder: (context, url) => new Container(
                    height: 80,
                    width: 80,
                    color: Colors.transparent,
                    child: Container(
                        height: 80,
                        width: 80,
                        child: Center(child: CircularProgressIndicator())),
                  ),
                  errorWidget: (context, url, error) => new Container(
                    height: 80,
                    width: 80,
                    color: MyColors.grey,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.userName}",
                            style: MyColors.styleBold1,
                          ),
                          Text(
                            "${widget.time}",
                            style: MyColors.styleNormal0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              "${widget.comment}",
                              style: TextStyle(height: 1.1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
