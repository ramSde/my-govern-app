import 'dart:typed_data';

import 'package:mygovern/Core/Constant/string.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import '../../model/invoice.dart';

Future<Uint8List> makePdf(requireddataforpdf invoice) async {
  final pdf = Document(
    
  );
  final gujaratifont =
      Font.ttf(await rootBundle.load("assets/fonts/gujartifont.ttf"));
  final terafont = Font.ttf(await rootBundle.load("assets/fonts/TERAFONT.ttf"));
  final fontstyle = TextStyle(fontSize: 18);
  final dottedstyle = TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 20,
    decorationStyle: TextDecorationStyle.solid,
  );
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/images/aadhaarforpdf.png'))
          .buffer
          .asUint8List());
  pdf.addPage(

    Page(

      theme: ThemeData.withFont(base: gujaratifont),
      build: (context) {
        return Column(
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("અરજદારનો રૂબરૂ જવાબ",
                    style: TextStyle(font: gujaratifont, fontSize: 30)),
              ],
            ),
            // SizedBox(
            //   height: 150,
            //   width: 150,
            //   child: Image(imageLogo),
            // )

            Container(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(children: [
                      Text(
                          "        હું   નીચે   સહી   કરનાર   શ્રી   /   શ્રીમતી   /   કુમારી   ",
                          style: fontstyle),
                      Text("${invoice.name}", style: dottedstyle),
                    ]),
                    Row(children: [
                      Text("ઉ.વ.આ", style: fontstyle),
                      SizedBox(width: 10),
                      Text("${invoice.dateofbirth}", style: dottedstyle),
                      SizedBox(width: 10),
                      Text("રહેવાસી:", style: fontstyle),
                      SizedBox(width: 10),
                      Text("${invoice.address}", style: dottedstyle),
                    ]),
                    Text(
                        ".......................................................................................................................................",
                        style: TextStyle(font: gujaratifont, fontSize: 20)),
                    Text(
                        ".......................................................................................................................................",
                        style: TextStyle(font: gujaratifont, fontSize: 20)),
                    SizedBox(height: 10),
                    Text(
                        "        આજરોજ રૂબરૂ પુછવાથી બતાવુ છું કે, આવકનું પ્રમાણપત્ર મેળવવા માટે મેં અરજી કરેલ છે ",
                        style: fontstyle),
                    Row(children: [
                      Text("જેમાં મારી સહી છે. મારા કુટુંબમાં કુલ ",
                          style: fontstyle),
                      Text("    ${invoice.familymambercount}    ",
                          style: dottedstyle),
                      Text("વ્યકિતઓ છે જે પૈકી કમાનાર વ્યકિતઓની સંખ્યા ",
                          style: fontstyle),
                    ]),
                    Row(children: [
                      Text("${invoice.getincome}    ", style: dottedstyle),
                      Text("છે.", style: fontstyle),
                    ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Text(
                          "        અમો ટેલીફોનનું જોડાણ ધરાવીએ છીએ જેનું માસિક બીલ રૂા  ",
                          style: fontstyle),
                      Text("${invoice.lightbill}    ", style: dottedstyle),
                      Text("ચુકવીએ છીએ.", style: fontstyle),
                    ]),
                    Row(children: [
                      Text(
                          "તેમજ અમો મોબાઈલ ફોન પણ ધરાવીએ છીએ અને તેનું માસિક બીલ રૂા",
                          style: fontstyle),
                      Text("  ${invoice.lightbill}  ", style: dottedstyle),
                      Text("ચુકવીએ છીએ.", style: fontstyle),
                    ]),
                    Row(children: [
                      Text("લાઈટબીલ માસિક રૂા", style: fontstyle),
                      Text("  ${invoice.lightbill}  ", style: dottedstyle),
                      Text("ભરીએ છીએ. તેમજ ઘરમાં ટેલીવિઝન તેમજ કેબલ",
                          style: fontstyle),
                    ]),
                    Row(children: [
                      Text("કનેકશન છે/નથી. જેના માસિક રૂા", style: fontstyle),
                      Text("  ${invoice.lightbill}  ", style: dottedstyle),
                      Text("ચાર્જ ઓપરેટરને આપીએ છીએ.", style: fontstyle),
                    ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Text(
                          "        તેમજ ઘરમાં/ધરના સભ્યો પાસે સ્કુટર, લ્યુના, મોટરસાઈકલ, ફ્રીજ, એરકંડીશનર, ઘરઘંટી, ",
                          style: fontstyle),
                    ]),
                    Text("ગીઝર પણ છે.", style: fontstyle),
                    Row(children: [
                      Text("        આ તમામ બાબતનો ", style: fontstyle),
                      Text("  ${invoice.lightbill}  ", style: dottedstyle),
                      Text("વાર્ષકિ આવક રૂપિયા.", style: fontstyle),
                      Text("  ${invoice.lightbill}  ", style: dottedstyle),
                      Text("છે.", style: fontstyle),
                    ]),
                    SizedBox(height: 20),
                    Text(
                        "અમો મુળ ગુજરાત રાજયના વતની છીએ. અમો ઉપર બતાવેલ જવાબ મારા લખાવ્યા પ્રમાણે બરાબર\n છે જે વાંચી સમજીને સહી કરેલ છે.",
                        style: fontstyle),
                    SizedBox(height: 20),
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text("સ્થળ :", style: fontstyle),
                                  SizedBox(width: 10),
                                  Text("  ${invoice.place}  ",
                                      style: dottedstyle),
                                ]),
                                Row(children: [
                                  Text("તારીખ :", style: fontstyle),
                                  Text("  ${invoice.date}  ",
                                      style: dottedstyle),
                                ])
                              ]),
                          SizedBox(width: 130),
                          Column(children: [
                            SizedBox(height: 30),
                            Text(
                                "..............................................",
                                style: TextStyle(
                                    font: gujaratifont, fontSize: 20)),
                            Text("અરજદારનું નામ / સહી / અંગુઠાનું નિશાન",
                                style: fontstyle)
                          ]),
                        ]),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("રૂબરૂ",
                    style: TextStyle(font: gujaratifont, fontSize: 20)),
                Text("..............................................",
                    style: TextStyle(font: gujaratifont, fontSize: 30)),
                Text("તલાટીની સહી / નામ / સિક્કો",
                    style: TextStyle(font: gujaratifont, fontSize: 20)),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
