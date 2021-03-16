import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pm_flutter/pages/contact/contact.dart';
import 'package:simple_pm_flutter/pages/message/message.dart';
import 'package:simple_pm_flutter/pages/mine/mine.dart';
import 'package:simple_pm_flutter/provider/contact_provider.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  int _tabIndex = 0;


  /// 获取联系人数据
  Future<void> _getContactList() async {
    await Provider.of<ContactProvider>(context, listen: false).getContactList();
  }

  @override
  void initState() {
    super.initState();
    _getContactList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          Message(),
          Contact(),
          Mine()
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        backgroundColor: Colors.white,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        items: [
          // BottomNavigationBarItem(
          //     label: '项目',
          //     icon: Icon(Icons.home, color: Colors.grey),
          //     activeIcon: Icon(Icons.home, color: Colors.red)
          // ),
          BottomNavigationBarItem(
              label: 'Message',
              icon: Icon(Icons.notification_important, color: Colors.grey),
              activeIcon: Icon(Icons.notification_important, color: Colors.red)
          ),
          BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(Icons.calendar_today_sharp, color: Colors.grey),
              activeIcon: Icon(Icons.calendar_today_sharp, color: Colors.red)
          ),
          BottomNavigationBarItem(
              label: 'Me',
              icon: Icon(Icons.sentiment_very_satisfied, color: Colors.grey),
              activeIcon: Icon(Icons.sentiment_very_satisfied, color: Colors.red)
          ),
        ],
      ),
    );
  }
}
