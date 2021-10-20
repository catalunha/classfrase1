// import 'dart:collection';
// import 'dart:typed_data';

// import 'package:classfrase/classification/controller/classification_model.dart';
// import 'package:classfrase/phrase/controller/phrase_model.dart';
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class PdfObserverPage extends StatelessWidget {
//   final List<String> phraseList;
//   final Map<String, ClassGroup> group;
//   final Map<String, ClassCategory> category;

//   final Map<String, Classification> phraseClassifications;
//   final List<String> classOrder;
//   final String authorDisplayName;
//   final String authorPhoto;
//   PdfObserverPage({
//     Key? key,
//     required this.phraseList,
//     required this.group,
//     required this.category,
//     required this.phraseClassifications,
//     required this.classOrder,
//     required this.authorDisplayName,
//     required this.authorPhoto,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ClassFrase em PDF')),
//       // body: IconButton(
//       //   icon: Icon(Icons.print),
//       //   onPressed: () async {
//       //     await Printing.layoutPdf(
//       //         onLayout: (format) => _generatePdf(format, title));
//       //   },
//       // ),
//       body: PdfPreview(
//         build: (format) => _generatePdf(format, 'ClassFrase em PDF'),
//       ),
//     );
//   }

//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font1 = await PdfGoogleFonts.openSansRegular();
//     final font2 = await PdfGoogleFonts.openSansBold();
//     var image;

//     try {
//       final provider = await flutterImageProvider(NetworkImage(authorPhoto));
//       image = provider;
//     } catch (e) {
//       print("****ERROR: $e****");
//       // return;
//     }
//     pdf.addPage(
//       pw.MultiPage(
//         theme: pw.ThemeData.withFont(
//           base: font1,
//           bold: font2,
//         ),
//         // pageFormat: format.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
//         pageFormat: format.copyWith(
//           marginTop: 1.0 * PdfPageFormat.cm,
//           marginLeft: 1.5 * PdfPageFormat.cm,
//           marginRight: 1.0 * PdfPageFormat.cm,
//           marginBottom: 1.0 * PdfPageFormat.cm,
//         ),
//         orientation: pw.PageOrientation.portrait,
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         // header: (pw.Context context) {
//         //   if (context.pageNumber == 1) {
//         //     return pw.SizedBox();
//         //   }
//         //   return pw.Container(
//         //       alignment: pw.Alignment.centerRight,
//         //       margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//         //       padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//         //       decoration: const pw.BoxDecoration(
//         //           border: pw.Border(
//         //               bottom:
//         //                   pw.BorderSide(width: 0.5, color: PdfColors.grey))),
//         //       child: pw.Text('ClassFrase',
//         //           style: pw.Theme.of(context)
//         //               .defaultTextStyle
//         //               .copyWith(color: PdfColors.grey)));
//         // },
//         footer: (pw.Context context) {
//           return pw.Container(
//             alignment: pw.Alignment.centerRight,
//             margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
//             child: pw.Text(
//               'Feito com carinho pela Família Catalunha. ClassFrase (R) 2021. Ore por nós, que Deus te abençõe. Pág.: ${context.pageNumber} de ${context.pagesCount}',
//               style: pw.TextStyle(fontSize: 10),
//               // style: pw.Theme.of(context)
//               //     .defaultTextStyle
//               //     .copyWith(color: PdfColors.grey),
//             ),
//           );
//         },
//         build: (pw.Context context) => <pw.Widget>[
//           // pw.Header(
//           //     level: 0,
//           //     title: 'ClassFrase',
//           //     child: pw.Row(
//           //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           //         children: <pw.Widget>[
//           //           pw.Text('ClassFrase', textScaleFactor: 2),
//           //           pw.PdfLogo()
//           //         ])),
//           pw.Header(level: 1, text: 'Frase:'),

//           pw.Center(
//             child: pw.Text(
//               phraseList.join(),
//               style: pw.TextStyle(
//                 fontSize: 18,
//                 color: PdfColors.black,
//               ),
//             ),
//           ),
//           // pw.Center(child: pw.Paragraph(text: phraseList.join())),
//           // pw.Header(level: 1, text: 'Frase'),
//           // pw.Center(child: pw.Paragraph(text: phraseList.join())),
//           pw.Header(level: 1, text: 'Classificador:'),
//           pw.Row(
//             mainAxisSize: pw.MainAxisSize.min,
//             children: [
//               pw.SizedBox(width: 20),
//               pw.Image(
//                 image,
//                 width: 50,
//                 height: 100,
//               ),
//               pw.SizedBox(width: 20),
//               pw.Text(authorDisplayName),
//             ],
//           ),
//           pw.Header(level: 1, text: 'Classificações:'),
//           // pw.Paragraph(text: 'Jesus é o caminho, a verdade e a vida.'),
//           // // pw.RichText(
//           // //   text: pw.TextSpan(
//           // //       style: pw.TextStyle(
//           // //         fontSize: 16,
//           // //         color: PdfColors.black,
//           // //       ),
//           // //       children: buildPhrase(context)),
//           // // ),
//           // pw.Bullet(text: 'Adjetivo.'),
//           // pw.Bullet(
//           //   text: 'Adverbio',
//           //   bulletShape: pw.BoxShape.rectangle,
//           //   margin: pw.EdgeInsets.only(left: 20),
//           // ),
//           // pw.Bullet(text: 'Verbo'),

//           ...buildClassByLine(context),
//           pw.Header(level: 1, text: 'Diagramas:'),
//         ],
//       ),
//     );

//     return pdf.save();
//   }

//   // List<pw.Widget> buildClassByLine2(context) {
//   //   List<pw.Widget> list = [];

//   //   list.add(pw.Paragraph(text: 'Jesus é o caminho, a verdade e a vida.'));
//   //   return list;
//   // }

//   List<pw.Widget> buildClassByLine(context) {
//     List<pw.Widget> lineList = [];

//     Map<String, ClassGroup> groupSorted = SplayTreeMap.from(group,
//         (key1, key2) => group[key1]!.title.compareTo(group[key2]!.title));

//     for (var classId in classOrder) {
//       Classification classification = phraseClassifications[classId]!;
//       //+++ montando a frase com a seleção
//       List<pw.InlineSpan> listSpan = [];
//       for (var i = 0; i < phraseList.length; i++) {
//         listSpan.add(pw.TextSpan(
//           text: phraseList[i],
//           style:
//               phraseList[i] != ' ' && classification.posPhraseList.contains(i)
//                   ? pw.TextStyle(
//                       color: PdfColors.orange900,
//                       decoration: pw.TextDecoration.underline,
//                       decorationStyle: pw.TextDecorationStyle.solid,
//                     )
//                   : null,
//         ));
//       }
//       pw.RichText richText = pw.RichText(
//         text: pw.TextSpan(
//           style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
//           children: listSpan,
//         ),
//       );
//       //--- montando a frase com a seleção

//       //+++ montando a classificação se houver
//       List<pw.Widget> categoryWidgetList = [];
//       for (var groutItem in groupSorted.entries) {
//         List<String> categoryIdList = classification.categoryIdList;
//         List<String> categoryTitleList = [];
//         for (var id in categoryIdList) {
//           if (category.containsKey(id)) {
//             if (category[id]!.group == groutItem.key) {
//               categoryTitleList.add(category[id]!.title);
//             }
//           }
//         }
//         if (categoryTitleList.isNotEmpty) {
//           categoryTitleList.sort();
//           categoryWidgetList.add(
//             pw.Bullet(
//               text:
//                   '${groutItem.value.title}: ${categoryTitleList.join(" | ")}',
//             ),
//           );
//           // categoryWidgetList.add(
//           //   pw.Padding(
//           //     padding: pw.EdgeInsets.only(left: 20),
//           //     child: pw.Text(
//           //       '${groutItem.value.title}: ${categoryTitleList.join(" | ")}',
//           //     ),
//           //   ),
//           // );
//           // for (var categoryTitle in categoryTitleList) {
//           //   categoryWidgetList.add(pw.Bullet(
//           //     text: '$categoryTitle',
//           //     bulletShape: pw.BoxShape.rectangle,
//           //     margin: pw.EdgeInsets.only(left: 20),
//           //   ));
//           // }
//         }
//         // if (categoryTitleList.isNotEmpty) {
//         //   categoryWidgetList.add(pw.Bullet(
//         //     text: '${groutItem.value.title}',
//         //   ));
//         //   categoryTitleList.sort();
//         //   for (var categoryTitle in categoryTitleList) {
//         //     categoryWidgetList.add(pw.Bullet(
//         //       text: '$categoryTitle',
//         //       bulletShape: pw.BoxShape.rectangle,
//         //       margin: pw.EdgeInsets.only(left: 20),
//         //     ));
//         //   }
//         // }
//       }
//       lineList.add(pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: <pw.Widget>[
//             richText,
//             ...categoryWidgetList,
//           ]));
//       // lineList.add(
//       //   Container(
//       //     alignment: Alignment.topCenter,
//       //     // width: double.infinity,
//       //     key: ValueKey(classId),
//       //     child: Card(
//       //       elevation: 25,
//       //       child: Padding(
//       //         padding: const EdgeInsets.all(8.0),
//       //         child: Column(
//       //           children: [
//       //             SingleChildScrollView(
//       //               scrollDirection: Axis.horizontal,
//       //               child: Row(
//       //                 children: [richText],
//       //               ),
//       //             ),
//       //             ...categoryWidgetList,
//       //           ],
//       //         ),
//       //       ),
//       //     ),
//       //   ),
//       // );
//     }
//     return lineList;
//   }
// }
