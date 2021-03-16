import 'package:flutter/material.dart';
import 'package:simple_pm_flutter/config/api.dart';
import 'package:simple_pm_flutter/config/http_manager.dart';
import 'package:simple_pm_flutter/model/base_bean.dart';
import 'package:simple_pm_flutter/model/contact.dart';

class ContactProvider with ChangeNotifier {

  // 联系人列表
  List<ContactData>  contactList = [];

  List<String> letters = ['A', 'B','C','D', 'E','F','G', 'H','I','J', 'K','L','M', 'N','O','P', 'Q','R','S', 'T','U','V', 'W','X','Y', 'Z'];

  // 获取联系人信息
  Future<void> getContactList() async {
    BaseBean res = await HttpManager.getInstance().get(Api.contactList);
    if(res.code == 10000) {
      res.data.forEach((item) {
        // String firstLetter = item.foreignName.substring(0,1).toUpperCase();
        contactList.add(ContactData.fromJson(item));
      });
    }
    notifyListeners();
  }
}
