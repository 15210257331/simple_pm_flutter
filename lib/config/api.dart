class Api {

  static String baseApi = "https://fapi-smix1.t.blingabc.com/";

  /// 登录接口
  static String login = baseApi + "fts/open-api/foreign/v1/app-login";

  /// 获取联系人
  static String contactList = baseApi + "fts/user-api/talk/v1/app-foreignlist?adminId=20";
}