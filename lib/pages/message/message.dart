import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_pm_flutter/pages/message/message_detail.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();

  List<Map<String, dynamic>> contactList = [
    {'name': 'asdfa', 'url': 'adsfaf'},
    {'name': 'asdfa', 'url': 'adsfaf'},
    {'name': 'asdfa', 'url': 'adsfaf'},
    {'name': 'asdfa', 'url': 'adsfaf'},
    {'name': 'asdfa', 'url': 'adsfaf'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Message',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Column(
        children: [_buildSearch(), _buildContacts()],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: TextField(
        controller: _emailController,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 15),
          prefixIcon: Icon(Icons.search, color: Colors.red),
          fillColor: Color(0xffF4F4F4),
          hintText: 'search',
          filled: true,
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(20), //边角为5
            ),
            borderSide: BorderSide(
              color: Colors.white, //边线颜色为白色
              width: 1, //边线宽度为2
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white, //边框颜色为白色
              width: 1, //宽度为5
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20), //边角为30
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContacts() {
    return Expanded(
      child: ListView.separated(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.2,
              child:  GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MessageDetail()
                  ));
                },
                child:  ListTile(
                  // contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage("assets/images/default-avatar.png"),
                  ),
                  title: Text(contactList[index]['name']),
                  subtitle: Text('下午好'),
                  trailing: Column(
                    children: [
                      Text('昨天'),
                      Badge(
                        padding: EdgeInsets.all(6),
                        showBadge: true,
                        badgeColor: Colors.deepOrangeAccent,
                        badgeContent: Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Archive',
                  color: Colors.blue,
                  icon: Icons.archive,
                  onTap: () => print('Archive'),
                ),
                IconSlideAction(
                  caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: () => print('Share'),
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'More',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: () => print('More'),
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => print('Delete'),
                ),
              ],
            );
          },
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[200],
              height: 1.0,
              thickness: 1.0,
            );
          }),
    );
  }

  Widget _buildMessageItem() {
    return Container(
      child: Row(
        children: [],
      ),
    );
  }
}
