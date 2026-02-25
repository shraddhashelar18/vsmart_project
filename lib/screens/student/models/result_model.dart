class ResultModel {
  final int semester;
  final bool ct1Declared;
  final bool ct2Declared;

  final bool finalDeclared;
  final bool finalUploadAllowed;
  final bool finalPdfUploaded;
  final bool reuploadAllowed;
  final List<double> currentSemData;
  final List<double> allSemData;

  ResultModel({
    required this.semester,
    required this.ct1Declared,
    required this.ct2Declared,
    required this.finalDeclared,
    required this.finalUploadAllowed,
    required this.finalPdfUploaded,
    required this.reuploadAllowed,
    required this.currentSemData,
    required this.allSemData,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      semester: json['semester'] ?? 0,
      ct1Declared: json['ct1Declared'] ?? false,
      ct2Declared: json['ct2Declared'] ?? false,
      finalDeclared: json['finalDeclared'] ?? false,
      finalUploadAllowed: json['finalUploadAllowed'] ?? false,
      finalPdfUploaded: json['finalPdfUploaded'] ?? false,
      reuploadAllowed: json['reuploadAllowed'] ?? false,
      currentSemData: (json['currentSemData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      allSemData: (json['allSemData'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
    );
  }
}
