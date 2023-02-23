import 'package:flutter/cupertino.dart';
import 'package:submission/data/sharedpreferences/shared_preferences.dart';

class SharedPreferenceProvider extends ChangeNotifier {
  PreferenceHelper preferenceHelper;

  SharedPreferenceProvider({required this.preferenceHelper}) {
    _getDailyNewsStatus();
  }

  bool _isReminder = false;
  bool get isReminder => _isReminder;

  void _getDailyNewsStatus() async {
    _isReminder = await preferenceHelper.isReminder;

    notifyListeners();
  }

  void setDailyNewsStatus(bool value) async {
    preferenceHelper.setDailyNews(value);
    _getDailyNewsStatus();
  }
}
