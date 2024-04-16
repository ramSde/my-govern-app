// import 'package:flutter/material.dart';
// import 'package:mygovern/Screens/syncpdf/savefile.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class CreatePdf extends StatefulWidget {
//   const CreatePdf({super.key});

//   @override
//   State<CreatePdf> createState() => _CreatePdfState();
// }

// class _CreatePdfState extends State<CreatePdf> {
//   Future<void> _createPDF() async {
//     //Create a PDF document.
//     var document = PdfDocument();

//     //Add page and draw text to the page.
//     document.pages.add().graphics.drawString(
//         'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 18),
//         brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//         bounds: Rect.fromLTWH(0, 0, 500, 30));

//     //Save the document
//     List<int> bytes = await document.save();

//     // Dispose the document
//     document.dispose();

//     //Save the file and launch/download
//     SaveFile.saveAndLaunchFile(bytes, 'output.pdf');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           // child: _createPDF,
//           ),
//     );
//   }
// }
