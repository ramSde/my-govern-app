import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:mygovern/Logic/Widgets/bookmark_card.dart';

import '../category_for_document/cat_for_doc.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
   List bookmarkicon = [
      "aadhaar.png",
      "pancard.png",
      "lic.png",
      "rationcard.png",
      "ayushman.png",
      "voter.png",
      "passport.png",
    ];

    List bookmarkname = [
      "આધાર કાર્ડ",
      "પાન કાર્ડ",
      "એલ આઇ સી વીમા",
      "રેશન કાર્ડ",
      "આયુષ્માન કાર્ડ",
      "મતદાર કાર્ડ",
      "પાસપોર્ટ"
    ];

    List subtitle = [
      "અનન્ય ઓળખ સત્તા",
      "આવક ટેક્સ વિભાગ",
      "જીવન વીમા યોજના",
      "કાનૂની ઓળખ પુરાવો",
      "તબીબી તપાસ, સારવાર અને કન્સલ્ટેશન ફી માટે કવરેજ પૂરું પાડે ",
      "ચૂંટણી પંચ દ્વારા જારી કરાયેલ ઓળખ દસ્તાવેજ",
      "દેશની નાગરિકતા"
    ];
     List bookmrk=[];

     bookmarfk() async{
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      setState(() {
        bookmrk=(snapshot.data() as Map<String,dynamic>)['Bookmark'];
      });
     }
    
     @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookmarfk();
  }
  @override
  Widget build(BuildContext context) {
   

    
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData ){
              return Center(child: CircularProgressIndicator());
            }
            final data = (snapshot.data as DocumentSnapshot)['Bookmark'];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatforDoc(
                          id: data[index],
                          documentname: data[index],
                        ),
                        settings: RouteSettings(
                          arguments: data[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
            child: ListTile(
             
              title: Text(
              data[index],
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
              ),
              
            ),
              ),
            )
                  // child: BookmarkCard(
                  //   documentname: bookmarkname[index],
                  //   documentimage: "assets/icons/" + bookmarkicon[index],
                  //   documentsubtitle: subtitle[index],
                  // ),
                );
              },
            );
          }
        );
      
    
  }
}
