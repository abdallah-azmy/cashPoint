import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SliderImage extends StatefulWidget {
  final img;

  const SliderImage({
    Key key,
    this.img,
  }) : super(key: key);

  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CachedNetworkImage(
        imageBuilder: (context, provider) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .27,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: provider, fit: BoxFit.cover)));
        },
        fit: BoxFit.cover,
        imageUrl: "${widget.img}",
        placeholder: (context, url) => new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .27,
          child: Center(child: CircularProgressIndicator()),
//                                  decoration: BoxDecoration(
//                                      image: DecorationImage(
//                                          image: AssetImage("assets/logo.png"),
//                                          fit: BoxFit.cover))
        ),
        errorWidget: (context, url, error) => new Container(
          color: MyColors.grey,
        ),
      ),
    );
  }
}
