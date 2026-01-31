class SemesterResult {
  final int semester;
  final bool ct1Declared;
  final bool ct2Declared;

  // FINAL EXAM (MSBTE)
  final bool finalDeclared;
  final bool finalUploadAllowed; // admin control
  final bool finalPdfUploaded;
  final bool reuploadAllowed; // admin control

  SemesterResult({
    required this.semester,
    required this.ct1Declared,
    required this.ct2Declared,
    required this.finalDeclared,
    required this.finalUploadAllowed,
    required this.finalPdfUploaded,
    required this.reuploadAllowed,
  });
}
