import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashpoint/src/LoadingDialog.dart';
import 'package:cashpoint/src/Network/api_provider.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:flutter/material.dart';
import 'package:cashpoint/src/firebaseNotification/appLocalization.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SelectCard extends StatefulWidget {
  final List<CategoryModel> list;
  final String title;
  final bool localization;
  final  selectLanguage;

  const SelectCard({Key key, this.list, this.title,this.selectLanguage,this.localization}) : super(key: key);

  @override
  _SelectCardState createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  SharedPreferences _prefs;

  getShared() async {
    _prefs = await SharedPreferences.getInstance();

  }



  @override
  void initState() {
    super.initState();
    getShared();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: widget.list.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget.localization
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : Container(),
                Row(
                  children: <Widget>[
                    Text(widget.list[index].label,
                        style: TextStyle(fontSize: 20)),
                    SizedBox(width: 10),
                    widget.title == "countries"
                        ? Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.list[index].image,
                              ))),
                      // child: Image.network(widget.list[index].image,fit: BoxFit.fill,
                      // height: 40,
                      // width: 60,),
                    )
                    //  CachedNetworkImage(
                    //     imageUrl: widget.list[index].image != null
                    //         ? ""
                    //         : widget.list[index].image,
                    //     errorWidget: (context, url, error) => Container(
                    //       height: 25,
                    //       width: 40,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: Center(
                    //           child: Text(widget.list[index].label)),
                    //     ),
                    //     fadeInDuration: Duration(seconds: 2),
                    //     placeholder: (context, url) => Container(
                    //         child: Text(widget.list[index].label),
                    //         height: 25,
                    //         width: 40,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //         )),
                    //     imageBuilder: (context, provider) {
                    //       return Container(
                    //           child: Image(
                    //             image: provider,
                    //             fit: BoxFit.cover,
                    //             height: 25,
                    //           ),
                    //           width: 40,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(5),
                    //           ));
                    //     },
                    //   )
                        : Container(
                      height: 40,
                      width: 60,
                      child: Image.asset(widget.list[index].image,fit: BoxFit.cover,),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryModel {
  int id;
  String label;
  bool selected;
  String image;

  CategoryModel({this.id, this.label, this.selected, this.image});
}
