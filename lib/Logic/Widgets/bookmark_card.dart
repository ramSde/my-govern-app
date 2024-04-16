// import 'package:flutter/material.dart';

// class BookmarkCard extends StatelessWidget {
//   String documentname;
//   String documentimage;
//   BookmarkCard(
//       {required this.documentname, required this.documentimage, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
//       child: Card(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: BorderSide(color: Colors.grey.withOpacity(0.4))),
//         child: SizedBox(
//           width: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.withOpacity(0.4)),
//                       borderRadius: BorderRadius.circular(50)),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 35,
//                     child: Image.asset(
//                       documentimage,
//                       height: 40,
//                       width: 40,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 Flexible(
//                     child: Text(documentname,
//                         softWrap: true,
//                         maxLines: 2,
//                         overflow: TextOverflow.clip,
//                         textAlign: TextAlign.start,
//                         style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black))),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BookmarkCard extends StatelessWidget {
  String documentname;
  String documentimage;
  String documentsubtitle;
  BookmarkCard(
      {required this.documentname,
      required this.documentsubtitle,
      required this.documentimage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(50)),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 29,
              child: Image.asset(
                documentimage,
                height: 40,
                width: 40,
              ),
            ),
          ),
          title: Text(
            documentname,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          subtitle: Text(
            documentsubtitle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
