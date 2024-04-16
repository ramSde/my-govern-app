import 'package:flutter/material.dart';

class Steppercard extends StatelessWidget {
  String processname;
  int index;
  int size;
  Color color;
  Steppercard(
      {required this.processname,
      required this.index,
      required this.size,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.5),
                radius: 16,
                child: Text(
                  "$index",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: Text(
                processname,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: Colors.black),
              )),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          index != size
              ? Container(
                  height: 20,
                  width: 30,
                  child: VerticalDivider(
                    color: Colors.black,
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}
