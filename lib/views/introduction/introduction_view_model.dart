import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/setting.dart';
import 'package:isolationhero/core/services/database_helper.dart';

class IntroductionViewModel extends BaseViewModel {
  IntroductionViewModel();

  void setIntroductionComplete() async {
    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      helper.insert(Setting("introduction_viewed_by_user", 1));
    } catch (e) {
      print(e);
    }
  }
}