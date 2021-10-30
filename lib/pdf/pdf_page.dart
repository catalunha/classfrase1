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
  final String phraseFont;
  final String authorDisplayName;
  final String authorPhoto;
  final String pdfFileName;
  final String diagramUrl;

  PdfPage({
    Key? key,
    required this.phraseList,
    required this.groupList,
    required this.category,
    required this.phraseClassifications,
    required this.classOrder,
    required this.authorDisplayName,
    required this.authorPhoto,
    this.phraseFont = '',
    required this.pdfFileName,
    required this.diagramUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ClassFrase em PDF')),
      body: PdfPreview(
        pdfFileName: pdfFileName,
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
        theme: theme(font1, font2),
        pageFormat: pageFormat(format),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        footer: (pw.Context context) => footerPage(context),
        build: (pw.Context context) => <pw.Widget>[
          headerClassificator(image),
          phrase(),
          pw.Text(
            'Fonte: $phraseFont',
            style: pw.TextStyle(fontSize: 10),
          ),
          header('Classificações:'),
          ...buildClassByLine(context),
          header('Diagrama:'),
          pw.Row(children: [
            pw.Text(
              'PDF desta classificação: $pdfFileName.pdf  |  ',
              style: pw.TextStyle(fontSize: 10),
            ),
            pw.Text('Diagrama online: '),
            diagramUrl.isNotEmpty
                ? _UrlText('clique aqui.', diagramUrl)
                : pw.Text('não disponível.'),
          ])
        ],
      ),
    );

    return pdf.save();
  }

  pageFormat(format) {
    return format.copyWith(
      width: 21.0 * PdfPageFormat.cm,
      height: 29.7 * PdfPageFormat.cm,
      marginTop: 1.0 * PdfPageFormat.cm,
      marginLeft: 1.0 * PdfPageFormat.cm,
      marginRight: 1.0 * PdfPageFormat.cm,
      marginBottom: 1.0 * PdfPageFormat.cm,
    );
  }

  footerPage(context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
      decoration: const pw.BoxDecoration(
          border: pw.Border(
              top: pw.BorderSide(width: 1.0, color: PdfColors.black))),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'ClassFrase (R) 2021. Feito com carinho pela Família Catalunha. Ore por nós, que Deus te abençõe.',
            style: pw.TextStyle(fontSize: 10),
          ),
          pw.Text(
            'Pág.: ${context.pageNumber} de ${context.pagesCount}',
            style: pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  header(text) {
    return pw.Header(
      level: 1,
      child: pw.Text(text),
    );
  }

  phrase() {
    return pw.Center(
      child: pw.Text(
        phraseList.join(),
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 18,
          color: PdfColors.black,
        ),
      ),
    );
  }

  headerClassificator(image) {
    return pw.Header(
      level: 1,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text(authorDisplayName),
            pw.Text('Classificador da frase:'),
          ]),
          pw.Image(
            image,
            width: 50,
            height: 100,
          ),
        ],
      ),
    );
  }

  theme(font1, font2) {
    return pw.ThemeData.withFont(
      base: font1,
      bold: font2,
    );
  }

  List<pw.Widget> buildClassByLine(context) {
    List<pw.Widget> lineList = [];

    for (var classId in classOrder) {
      Classification classification = phraseClassifications[classId]!;

      // +++ Montando frase destacando a seleção
      List<pw.InlineSpan> listSpan = [];
      for (var i = 0; i < phraseList.length; i++) {
        listSpan.add(pw.TextSpan(
          text: phraseList[i],
          style:
              phraseList[i] != ' ' && classification.posPhraseList.contains(i)
                  ? pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
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

      // +++ Montando classificações desta seleção
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
      // Juntando frase e classificações
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

class _UrlText extends pw.StatelessWidget {
  _UrlText(this.text, this.url);

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(
        text,
        // style: const pw.TextStyle(
        //   decoration: pw.TextDecoration.underline,
        //   color: PdfColors.blue,
        // ),
      ),
    );
  }
}
