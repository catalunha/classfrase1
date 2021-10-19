 // IconButton(
          //     onPressed: () async {
          //       final pdf = pw.Document();
          //       print('pdf1');
          //       pdf.addPage(pw.Page(
          //           pageFormat: PdfPageFormat.a4,
          //           build: (pw.Context context) {
          //             return pw.Center(
          //               child: pw.Text("Hello World"),
          //             ); // Center
          //           }));
          //       // // On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
          //       // print('pdf2');
          //       // final directory = await getTemporaryDirectory();
          //       // print('pdf3 ${directory.path}');

          //       // final directory2 = Directory('/storage/emulated/0/Downloads');
          //       // final file = File("${directory2.path}/example.pdf");
          //       // print('pdf4: ${file.absolute}');
          //       // print('pdf4: ${file.path}');

          //       // print('pdf4:');
          //       final output = await getTemporaryDirectory();
          //       final file = File('${output.path}/example.pdf');
          //       await file.writeAsBytes(await pdf.save());
          //       await Printing.layoutPdf(
          //           onLayout: (PdfPageFormat format) async => pdf.save());
          //     },
          //     icon: Icon(Icons.print)),