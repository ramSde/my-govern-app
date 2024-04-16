import 'package:flutter/material.dart';

class Pdf_demo_card extends StatelessWidget {
  const Pdf_demo_card({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Image.asset(
            "assets/icons/pdf.png",
            height: 40,
            width: 40,
          ),
          title: const Text(
            "Download Document",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
