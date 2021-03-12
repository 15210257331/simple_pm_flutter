import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bling_extensions/bling_extensions.dart';
import 'package:simple_pm_flutter/global/user_info_manager.dart';
import 'package:simple_pm_flutter/home/home.dart';
import 'package:simple_pm_flutter/http/api.dart';
import 'package:simple_pm_flutter/http/http_manager.dart';
import 'package:simple_pm_flutter/model/base_bean.dart';
import 'package:simple_pm_flutter/model/user_info.dart';
import 'dart:convert' as convert;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  // 展示密码
  final ValueNotifier<bool> _showPassNotifier = ValueNotifier(false);

  // 邮箱
  final TextEditingController _emailController = TextEditingController();

  // 密码
  final TextEditingController _passController = TextEditingController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setLastTimeContent();
    });
  }

  // 填充上次登录的账号和密码
  setLastTimeContent() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    _emailController.value = _emailController.value.copyWith(
      text: email,
      selection:
      TextSelection(baseOffset: email.length, extentOffset: email.length),
      composing: TextRange.empty,
    );
    _passController.value = _passController.value.copyWith(
      text: password,
      selection:
      TextSelection(baseOffset: password.length, extentOffset: password.length),
      composing: TextRange.empty,
    );
  }

  /// 执行登录操作
  Future<void> login() async {
    String email = _emailController.text;
    String password = _passController.text;
    if(email.isBlank || password.isBlank) {
      // showToast('email or password required');
      return;
    }
    BaseBean res = await HttpManager.getInstance().post(Api.login, body: {"email": email.trim() ?? "", "password": password.trim() ?? ""});
    if(res.code == 10000) {
      // 储存用户信息
      String userInfoString = convert.jsonEncode(res.data);
      UserInfoManager.setUserInfo(userInfoString);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home(),
        settings: RouteSettings(name: "/"),
      ));
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  _buildBg(),
                  _buildLoginForm(),
                ],
              ),
            ),
          ),
        )
    );
  }

  /// 登录页面的背景
  Widget _buildBg() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          _buildLogo(),
          _buildWelcome(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Positioned(
      left: 15,
      top: 30,
      child: Image.asset("assets/images/login/logo.png", width: 160, height: 27, fit: BoxFit.cover),
      // child: Image(
      //   image: AssetImage(Res.home_logo),
      //   width: 120.0,
      //   height: 20.0,
      // ),
    );
  }

  Widget _buildWelcome() {
    return Positioned(
      top: 107,
      child: Text(
        "Welcome to BlingABC",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  /// 登录表单
  Widget _buildLoginForm() {
    return Positioned(
      top: 180,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(17),
            topLeft: Radius.circular(17),
          ),
        ),
        child: _buildForm(),
      ),
    );
  }

  /// 登录表单
  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
      child: Column(
        children: <Widget>[
          TextField(
              controller: _emailController,
              decoration: InputDecoration(
                suffixIcon: Image.asset("assets/images/login/icon_clear.png", scale: 1.5,).onTap(() => {
                  _clearEmail()
                }),
                hintText: 'Email address',
                hintStyle: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16),
                enabledBorder:  UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              )
          ),
          SizedBox(height: 30),
          ValueListenableBuilder(
            valueListenable: _showPassNotifier,
            builder: (context, flag, _) {
              return TextField(
                keyboardType: TextInputType.text,
                obscureText: flag ? false : true,
                controller: _passController,
                decoration: _createInputDecoration(hintText: 'Password', showSuffixIcon: true),
              );
            },
          ),
          _buildLoginBtn(),
        ],
      ),
    );
  }

  _clearEmail() {
    _emailController.clear();
  }

  InputDecoration _createInputDecoration({String hintText, bool showSuffixIcon = false}) {
    var hintStyle = TextStyle(color: Color(0xFFCCCCCC), fontSize: 16);
    // 文本框未获取焦点的时候下划线的颜色
    var enabledBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));
    // 文本框获取到焦点的时候下划线的颜色
    var focusedBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.red));
    return InputDecoration(
      suffixIcon: showSuffixIcon ? _buildSuffixIcon() : SizedBox.shrink(),
      hintText: hintText,
      hintStyle: hintStyle,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
    );
  }

  /// 登录按钮
  Widget _buildLoginBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        alignment: AlignmentDirectional.center,
        width: 315,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff7357FF),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text('Log In',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ).onTap(() => login()),
    );
  }

  /// 密码框后缀图标
  Widget _buildSuffixIcon() {
    return ValueListenableBuilder(
      valueListenable: _showPassNotifier,
      builder: (context, flag, _) {
        if (flag) {
          return Image.asset("assets/images/login/eye_open.png", scale: 1.5,);
        } else {
          return Image.asset("assets/images/login/eye_close.png", scale: 1.5,);
        }
      },
    ).onTap(() => _showPassNotifier.value = !_showPassNotifier.value, tapInterval: 200);
  }
}

