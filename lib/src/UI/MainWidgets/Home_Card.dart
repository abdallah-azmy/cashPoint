import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:cashpoint/src/UI/MainWidgets/CustomProductImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomeCard extends StatefulWidget {
  final id;
  final img;
  final category;


  const HomeCard(
      {Key key,
      this.id,
      this.img,
      this.category})
      : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 130,
          width: 135,
          child:

          CustomProductImage(image:  widget.img,)
//          CachedNetworkImage(
//            imageBuilder: (context, provider) {
//              return Container(
////              height: 100,
////              width: 105,
//                  decoration: BoxDecoration(
//                      color: Colors.transparent,
//                      borderRadius: BorderRadius.circular(10),
//                      image: DecorationImage(
//                          image: provider, fit: BoxFit.fill)));
//            },
//            fit: BoxFit.fill,
//            imageUrl: "${widget.img}",
//            placeholder: (context, url) => new Container(
//              height: 100,
//              width: 100,
//              color: Colors.transparent,
//              child: Container(
//                  height: 20,
//                  width: 20,
//                  child: Center(child: CircularProgressIndicator())),
//            ),
//            errorWidget: (context, url, error) => new Container(
////          height: 100,
////          width: 100,
//              color: MyColors.grey,
//            ),
//          ),
        ),
        SizedBox(height: 5,),
        Text("${widget.category}",style: MyColors.styleNormal0,)
      ],
    );
  }
}
