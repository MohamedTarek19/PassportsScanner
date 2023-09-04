import 'package:flutter/material.dart';

class CapturedTile extends StatelessWidget {
  CapturedTile({
    Key? key,
    required this.title,
    required this.data,

  }) : super(key: key);
  String title;
  String data;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text("$title : ",style: TextStyle(fontSize: 15),),
                Text('${data}',style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
