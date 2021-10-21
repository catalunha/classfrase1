import 'dart:typed_data';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatelessWidget {
  final List<String> phraseList;
  final List<ClassGroup> groupList;
  final Map<String, ClassCategory> category;

  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;
  final String authorDisplayName;
  final String authorPhoto;
  PdfPage({
    Key? key,
    required this.phraseList,
    required this.groupList,
    required this.category,
    required this.phraseClassifications,
    required this.classOrder,
    required this.authorDisplayName,
    required this.authorPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ClassFrase em PDF')),
      body: PdfPreview(
        build: (format) => _generatePdf(format, 'ClassFrase em PDF'),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    var image;

    try {
      final provider = await flutterImageProvider(NetworkImage(authorPhoto));
      image = provider;
    } catch (e) {
      print("--> Erro em _generatePdf: $e");
    }
    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
        pageFormat: format.copyWith(
          marginTop: 1.0 * PdfPageFormat.cm,
          marginLeft: 1.5 * PdfPageFormat.cm,
          marginRight: 1.0 * PdfPageFormat.cm,
          marginBottom: 1.0 * PdfPageFormat.cm,
        ),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: pw.Text(
              'Feito com carinho pela Família Catalunha. ClassFrase (R) 2021. Ore por nós, que Deus te abençõe. Pág.: ${context.pageNumber} de ${context.pagesCount}',
              style: pw.TextStyle(fontSize: 10),
            ),
          );
        },
        build: (pw.Context context) => <pw.Widget>[
          pw.Header(level: 1, text: 'Frase:'),
          pw.Center(
            child: pw.Text(
              phraseList.join(),
              style: pw.TextStyle(
                fontSize: 18,
                color: PdfColors.black,
              ),
            ),
          ),
          pw.Header(level: 1, text: 'Classificador:'),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.SizedBox(width: 20),
              pw.Image(
                image,
                width: 50,
                height: 100,
              ),
              pw.SizedBox(width: 20),
              pw.Text(authorDisplayName),
            ],
          ),
          pw.Header(level: 1, text: 'Classificações:'),
          ...buildClassByLine(context),
          pw.Header(level: 1, text: 'Diagramas:'),
        ],
      ),
    );

    return pdf.save();
  }

  List<pw.Widget> buildClassByLine(context) {
    List<pw.Widget> lineList = [];

    for (var classId in classOrder) {
      Classification classification = phraseClassifications[classId]!;
      List<pw.InlineSpan> listSpan = [];
      for (var i = 0; i < phraseList.length; i++) {
        listSpan.add(pw.TextSpan(
          text: phraseList[i],
          style:
              phraseList[i] != ' ' && classification.posPhraseList.contains(i)
                  ? pw.TextStyle(
                      color: PdfColors.orange900,
                      decoration: pw.TextDecoration.underline,
                      decorationStyle: pw.TextDecorationStyle.solid,
                    )
                  : null,
        ));
      }
      pw.RichText richText = pw.RichText(
        text: pw.TextSpan(
          style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
          children: listSpan,
        ),
      );

      List<pw.Widget> categoryWidgetList = [];
      for (var group in groupList) {
        List<String> categoryIdList = classification.categoryIdList;
        List<String> categoryTitleList = [];
        for (var id in categoryIdList) {
          if (category.containsKey(id)) {
            if (category[id]!.group == group.id) {
              categoryTitleList.add(category[id]!.title);
            }
          }
        }
        if (categoryTitleList.isNotEmpty) {
          categoryTitleList.sort();
          categoryWidgetList.add(
            pw.Bullet(
              text: '${group.title}: ${categoryTitleList.join(" | ")}',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.black),
            ),
          );
        }
      }
      lineList.add(pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            richText,
            ...categoryWidgetList,
          ]));
    }
    return lineList;
  }
}
