import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainWidgets/Special_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';

class SliderCard extends StatefulWidget {
  final img;
  final onTap;
  final id;
  final apiToken;
  final orderId;
  final scaffold;
  final getData;

  const SliderCard(
      {Key key,
      this.apiToken,
      this.img,
      this.scaffold,
      this.onTap,
      this.orderId,
      this.getData,
      this.id})
      : super(key: key);

  @override
  _SliderCardState createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
//              color: Colors.white,
              borderRadius: BorderRadius.circular(11)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.width * .61,
                      width: MediaQuery.of(context).size.width * .71,
                      fit: BoxFit.fill,
                      imageUrl: widget.img == null ? " " : "${widget.img}",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: MediaQuery.of(context).size.width * .5,
                            width: MediaQuery.of(context).size.width * .7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) => new Container(
                        height: MediaQuery.of(context).size.width * .5,
                        width: MediaQuery.of(context).size.width * .7,
//                                      color: MyColors.grey,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      placeholderFadeInDuration: Duration(milliseconds: 500),
                      errorWidget: (context, url, error) => new Container(
                        height: MediaQuery.of(context).size.width * .5,
                        width: MediaQuery.of(context).size.width * .7,
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: widget.onTap,
                      child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.cancel)),
                    ),
                    left: 9,
                    top: 9,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
