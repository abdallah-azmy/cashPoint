import 'package:flutter/material.dart';

class CustomProductImage extends StatefulWidget {
  final String image;
  var circular ;

   CustomProductImage({Key key, @required this.image,this.circular}) : super(key: key);

  @override
  _CustomProductImageState createState() => _CustomProductImageState();
}

class _CustomProductImageState extends State<CustomProductImage> {
  @override
  Widget build(BuildContext context) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.circular ?? 8.0),
        child: Image.network(
          widget.image,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      );
    } catch (e) {
      print(e);
      return Image.asset("assets/cashpoint/cashlogoo.png");
    }
  }
}