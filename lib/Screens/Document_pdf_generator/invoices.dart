import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygovern/Logic/Widgets/bookmark_card.dart';
import 'package:mygovern/Screens/Document_pdf_generator/pdfexport/pdfpreview.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../syncpdf/savefile.dart';
import 'model/invoice.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({Key? key}) : super(key: key);

  final requireddata = <requireddataforpdf>[
    requireddataforpdf(
        dateofbirth: "10-01-2002",
        address: "107 સ્વામિનારાયણ નગર સિમડા ગામ, સુરત",
        phonenumber: "7359543703",
        name: "યશકુમાર રાંક",
        documentname: "આધાર કાર્ડ",
        date: "08-10-2022",
        familymambercount: 5,
        getincome: 4,
        income: 140000,
        lightbill: 1500,
        place: "Surat"),
    requireddataforpdf(
        dateofbirth: "18-11-2002",
        address: "શેરી નં. 4, મારુતિનગર, ઘોઘા રોડ, ભાવનગર",
        phonenumber: "7359543703",
        name: "સિંધા વિપેન્દ્રાસિંહ",
        documentname: "આધાર કાર્ડ",
        date: "08-10-2022",
        familymambercount: 5,
        getincome: 4,
        income: 140000,
        lightbill: 1500,
        place: "Bhavnagar"),
    requireddataforpdf(
        dateofbirth: "16-10-2002",
        address: "શેરી નં. 4, મારુતિનગર, ઘોઘા રોડ, ભાવનગર",
        phonenumber: "7359543703",
        name: "મેહુલ રામ",
        documentname: "આધાર કાર્ડ",
        date: "08-10-2022",
        familymambercount: 5,
        getincome: 4,
        income: 140000,
        lightbill: 1500,
        place: "Una"),
    requireddataforpdf(
        dateofbirth: "13-05-2002",
        address: "107 surat gujarat india",
        phonenumber: "7359543703",
        name: "ધવલ તરસરિયા",
        documentname: "આધાર કાર્ડ",
        date: "08-10-2022",
        familymambercount: 5,
        getincome: 4,
        income: 140000,
        lightbill: 1500,
        place: "Surat"),
  ];

  late String username;
  late String dob;
  late String aadharno;
  late String panno;
  late String passport;
  @override
  Widget build(BuildContext context) {
    // Future<void> _createPDF() async {
    //   //Create a PDF document.
    //   var document = PdfDocument();

    //   //Add page and draw text to the page.
    //   document.pages.add().graphics.drawString(
    //       'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 18),
    //       brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    //       bounds: Rect.fromLTWH(0, 0, 500, 30));

    //   //Save the document
    //   List<int> bytes = await document.save();

    //   // Dispose the document
    //   document.dispose();

    //   //Save the file and launch/download
    //   SaveFile.saveAndLaunchFile(bytes, 'output.pdf');
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Document'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
              future: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.data!;
                if (snapshot.data!.exists) {
                  username = data.get('name');
                  dob = data.get('dob');
                  passport = data.get('passport');
                  aadharno = data.get('aadhar');
                  panno = data.get('pan');
                }

                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (builder) => CreatePdf(),
                    //   ),
                    // );
                    // _createPDF();
                  },
                  child: BookmarkCard(
                    documentimage: "assets/icons/national.png",
                    documentname: username,
                    documentsubtitle: "અરજદારનો રૂબરૂ જવાબ",
                  ),
                );
              }),
          ...requireddata.map((e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => PdfPreviewPage(invoice: e),
                    ),
                  );
                },
                child: BookmarkCard(
                    documentname: e.name,
                    documentsubtitle: "અરજદારનો રૂબરૂ જવાબ",
                    documentimage: "assets/icons/national.png"),
              )),
        ],
      ),
    );
  }
}
