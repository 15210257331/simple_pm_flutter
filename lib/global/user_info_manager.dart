import 'package:simple_pm_flutter/global/global.dart';

class UserInfoManager {
  String _userId;

  static String get userId {
    return UserInfoManager._getInstance._userId;
  }

  static void setUserId(String userId) {
    preferences.setString('userId', userId);
  }

  String _userInfo;

  static String get userInfo {
    return UserInfoManager._getInstance._userInfo;
  }

  static void setUserInfo(String userInfo) {
    preferences.setString('userInfo', userInfo);
  }

  static UserInfoManager _instance;

  static UserInfoManager get _getInstance {
    if (_instance == null) {
      _instance = UserInfoManager();
      _instance.loadUserFromLocal();

    }
    return _instance;
  }

  loadUserFromLocal() {
    _userId = preferences.getString('userId');
    _userInfo = preferences.getString('userInfo');
  }
}
