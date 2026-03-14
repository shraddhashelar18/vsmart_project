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
  final Map<String, dynamic> marks;

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
    required this.marks,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      semester: int.tryParse(json['active_semester'].toString()) ?? 0,
      ct1Declared: json['ct1_published'] == "1",
      ct2Declared: json['ct2_published'] == "1",
      finalDeclared: json['final_published'] == "1",
      finalUploadAllowed: json['allow_marksheet_upload'] == "1",
      finalPdfUploaded: false,
      reuploadAllowed: json['allow_reupload'] == "1",
      marks: Map<String, dynamic>.from(json['marks'] ?? {}),
      currentSemData: [],
      allSemData: [],
    );
  }
}
