import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_pm_flutter/config/theme_map.dart';
import 'package:simple_pm_flutter/provider/app_provider.dart';

class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> with SingleTickerProviderStateMixin {
  List tabs = ['语文', '数学', '英语', '政治', '历史', '地理', '物理', '化学', '生物'];
  TabController _tabController;

  String _colorKey;

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
        title: Text('CoderTitan'),
        backgroundColor: Colors.blueAccent,
        brightness: Brightness.dark,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          isScrollable: true,
          indicatorColor: Colors.red,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18, color: Colors.orange),
          unselectedLabelStyle: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ExpansionTile(
          leading: Icon(Icons.color_lens),
          title: Text('颜色主题'),
          initiallyExpanded: false,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: themeColorMap.keys.map((key) {
                  Color value = themeColorMap[key];
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        _colorKey = key;
                      });
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      // await prefs.setString('key_theme_color', key);
                      Provider.of<AppProvider>(context, listen: false)
                          .setTheme(key);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: value,
                      child: _colorKey == key
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
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
