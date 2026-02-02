class ResultModel {
  final int semester;
  final bool ct1Declared;
  final bool ct2Declared;

  final bool finalDeclared;
  final bool finalUploadAllowed;
  final bool finalPdfUploaded;
  final bool reuploadAllowed;

  ResultModel({
    required this.semester,
    required this.ct1Declared,
    required this.ct2Declared,
    required this.finalDeclared,
    required this.finalUploadAllowed,
    required this.finalPdfUploaded,
    required this.reuploadAllowed,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      semester: json['semester'],
      ct1Declared: json['ct1Declared'],
      ct2Declared: json['ct2Declared'],
      finalDeclared: json['finalDeclared'],
      finalUploadAllowed: json['finalUploadAllowed'],
      finalPdfUploaded: json['finalPdfUploaded'],
      reuploadAllowed: json['reuploadAllowed'],
    );
  }
}
