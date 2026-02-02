import '../models/result_model.dart';

class ResultsService {
  static Future<List<ResultModel>> fetchResults() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      ResultModel(
        semester: 1,
        ct1Declared: true,
        ct2Declared: true,
        finalDeclared: true,
        finalUploadAllowed: false,
        finalPdfUploaded: true,
        reuploadAllowed: false,
      ),
      ResultModel(
        semester: 2,
        ct1Declared: true,
        ct2Declared: true,
        finalDeclared: false,
        finalUploadAllowed: false,
        finalPdfUploaded: false,
        reuploadAllowed: false,
      ),
      ResultModel(
        semester: 3,
        ct1Declared: true,
        ct2Declared: false,
        finalDeclared: false,
        finalUploadAllowed: false,
        finalPdfUploaded: false,
        reuploadAllowed: false,
      ),
    ];
  }
}
