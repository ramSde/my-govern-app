import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import '../model/invoice.dart';
import 'pdf/pdfexport.dart';

class PdfPreviewPage extends StatelessWidget {
  final requireddataforpdf invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('અરજદારનો રૂબરૂ જવાબ'),
      ),
      body: PdfPreview(
        canDebug: false,
        canChangeOrientation: false,
        build: (context) => makePdf(invoice),
      ),
    );
  }
}
