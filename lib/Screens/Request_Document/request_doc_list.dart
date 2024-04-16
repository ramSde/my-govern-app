import 'package:flutter/material.dart';
import 'package:mygovern/Logic/Widgets/bookmark_card.dart';

import '../../Core/Constant/string.dart';

class RequestDocumentList extends StatelessWidget {
  const RequestDocumentList({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> docs = ['Pancard', 'Rationcard'];
    List docIcon = [
      "pancard.png",
      "rationcard.png",
    ];
    List subtitle = [
      "આવક ટેક્સ વિભાગ",
      "કાનૂની ઓળખ પુરાવો",
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ડોક્યુમેન્ટ રીક્વેસ્ટ'),
      ),
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, requestDocFormScreenRoute,
                  arguments: docs[index]);
            },
            child: BookmarkCard(
                documentname: docs[index],
                documentsubtitle: subtitle[index],
                documentimage: "assets/icons/" + docIcon[index]),
          );
        },
      ),
    );
  }
}
