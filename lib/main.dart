import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_pm_flutter/config/theme_map.dart';
import 'package:simple_pm_flutter/global/global.dart';
import 'package:simple_pm_flutter/global/user_info_manager.dart';
import 'package:simple_pm_flutter/pages/login.dart';
import 'package:simple_pm_flutter/pages/home.dart';
import 'package:simple_pm_flutter/provider/app_provider.dart';
import 'package:simple_pm_flutter/provider/contact_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化 SharedPreferences
  preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
  if(Platform.isAndroid){
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      // 设置状态栏的背景色
        statusBarColor: Colors.transparent,
        //这是设置状态栏的图标和字体的颜色
        //Brightness.light  一般都是显示为白色
        //Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  Color _themeColor;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
        ChangeNotifierProvider<ContactProvider>(create: (_) => ContactProvider())
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          String colorKey = appProvider.themeColor;
          if (themeColorMap[colorKey] != null) {
            _themeColor = themeColorMap[colorKey];
            print(_themeColor);
          }
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: _themeColor,
              cardColor: _themeColor,
              floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: _themeColor),
            ),
            home: UserInfoManager.userInfo != null ? Home() : Login(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
