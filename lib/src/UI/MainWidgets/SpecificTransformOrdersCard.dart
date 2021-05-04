import 'package:cashpoint/src/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SpecificTransferOrdersCard extends StatefulWidget {
  final branch;
  final distance;

  const SpecificTransferOrdersCard(
      {Key key,
      this.branch,
      this.distance,})
      : super(key: key);

  @override
  _SpecificTransferOrdersCardState createState() => _SpecificTransferOrdersCardState();
}

class _SpecificTransferOrdersCardState extends State<SpecificTransferOrdersCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
//
      decoration: BoxDecoration(
        color: Color(0xffdcdcdc),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [


              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  widget.branch,
                  style: MyColors.styleBoldSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "${widget.distance}",
                  style: MyColors.styleBoldSmall,
                  textAlign: TextAlign.center,
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}
