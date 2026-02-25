import '../../screens/student/models/result_model.dart';

final mockResults = [
  ResultModel(
    semester: 5,
    ct1Declared: true,
    ct2Declared: true,
    finalDeclared: true,
    finalUploadAllowed: false,
    finalPdfUploaded: true,
    reuploadAllowed: false,
    currentSemData: [78, 85, 90],
    allSemData: [72, 75, 80, 83, 86, 89],
  ),
  ResultModel(
    semester: 6,
    ct1Declared: false,
    ct2Declared: false,
    finalDeclared: false,
    finalUploadAllowed: false,
    finalPdfUploaded: false,
    reuploadAllowed: false,
    currentSemData: [0, 0, 0],
    allSemData: [72, 75, 80, 83, 86, 89],
  ),
];
