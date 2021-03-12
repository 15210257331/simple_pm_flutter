import 'package:flutter/material.dart';
import 'package:simple_pm_flutter/http/api.dart';
import 'package:simple_pm_flutter/http/http_manager.dart';
import 'package:simple_pm_flutter/model/base_bean.dart';
import 'package:simple_pm_flutter/model/contact.dart';

class ContactProvider with ChangeNotifier {

  // 联系人列表
  List<ContactData>  contactList = [];

  // 获取联系人信息
  Future<void> getContactList() async {
    BaseBean res = await HttpManager.getInstance().get(Api.contactList);
    if(res.code == 10000) {
      res.data.forEach((item) {
        contactList.add(ContactData.fromJson(item));
      });
    }
    notifyListeners();
  }
}
