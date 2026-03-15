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
    bool parseBool(value) {
      return value == 1 || value == "1" || value == true;
    }

    return ResultModel(
      semester: int.tryParse(json['active_semester'].toString()) ?? 0,
      ct1Declared: parseBool(json['ct1_published']),
      ct2Declared: parseBool(json['ct2_published']),
      finalDeclared: parseBool(json['final_published']),
      finalUploadAllowed: parseBool(json['allow_marksheet_upload']),
      finalPdfUploaded: false,
      reuploadAllowed: parseBool(json['allow_reupload']),
      marks: Map<String, dynamic>.from(json['marks'] ?? {}),
      currentSemData: [],
      allSemData: [],
    );
  }
}
