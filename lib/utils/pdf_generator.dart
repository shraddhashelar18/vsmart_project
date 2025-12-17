// lib/utils/pdf_generator.dart
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:typed_data';

class PdfGenerator {
  static Future<Uint8List> generateMarksheet({
    required String studentName,
    required Map<String, dynamic> marks,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("School Marksheet",
                    style: pw.TextStyle(
                      fontSize: 26,
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.SizedBox(height: 20),
                pw.Text("Student Name: $studentName",
                    style: pw.TextStyle(fontSize: 18)),
                pw.SizedBox(height: 20),

                pw.Table(
                  border: pw.TableBorder.all(width: 1),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                          color: PdfColors.grey300),
                      children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Subject",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("CT1")),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("CT2")),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text("Semester")),
                      ],
                    ),
                    ...marks.entries.map(
                      (e) => pw.TableRow(
                        children: [
                          pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(e.key)),
                          pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(e.value["ct1"].toString())),
                          pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(e.value["ct2"].toString())),
                          pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child:
                                  pw.Text(e.value["semester"].toString())),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
