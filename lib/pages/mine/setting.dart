import 'package:flutter/material.dart';
import 'package:simple_pm_flutter/global/user_info_manager.dart';
import 'package:simple_pm_flutter/pages/login.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: RaisedButton(
          child: Text('Log out'),
          onPressed: () {
            UserInfoManager.setUserInfo(null);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Login(),
              settings: RouteSettings(name: "/"),
            ));
          },
        ),
      ),
    );
  }
}
