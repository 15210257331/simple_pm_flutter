import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>  with SingleTickerProviderStateMixin{
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: AnnotatedRegion(
  //           value: SystemUiOverlayStyle.light,
  //           child: Container(
  //             color: Colors.greenAccent,
  //           )
  //       )
  //   );
  // }

  List tabs = ['通讯录', '聊天'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
            indicatorColor: Colors.red,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 18, color: Colors.orange),
            unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.black),
          )),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(e, style: TextStyle(fontSize: 50)),
          );
        }).toList(),
      ),
    );
  }
}
