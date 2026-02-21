import '../models/student.dart';
import 'app_settings_service.dart';

class PromotionService {
  final AppSettingsService _settingsService = AppSettingsService();

  Future<List<Student>> evaluatePromotion(List<Student> students) async {
    int atktLimit = await _settingsService.getAtktLimit();

    for (var student in students) {
      if (student.backlogCount == 0) {
        student.promotionStatus = "PROMOTED";
      } else if (student.backlogCount <= atktLimit) {
        student.promotionStatus = "PROMOTED_WITH_ATKT";
      } else {
        student.promotionStatus = "DETAINED";
      }
    }

    return students;
  }
}
