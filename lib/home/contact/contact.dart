import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  final TextEditingController _emailController = TextEditingController();

  List<Map<String,dynamic>> contactList = [
    {
      'name':'asdfa',
      'url': 'adsfaf'
    },
    {
      'name':'asdfa',
      'url': 'adsfaf'
    },
    {
      'name':'asdfa',
      'url': 'adsfaf'
    },
    {
      'name':'asdfa',
      'url': 'adsfaf'
    },
    {
      'name':'asdfa',
      'url': 'adsfaf'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text('Contacts',
            style: TextStyle(
              color: Colors.black
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          ),
      body: Column(
          children: [
            _buildSearch(),
            _buildContacts()
          ],
        ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 15,right: 15),
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
        child: ListView.builder(
            itemCount: contactList.length,
            itemExtent: 70,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/default-avatar.png"),
                ),
                title: Text(contactList[index]['name']),
              );
            }
        )
    );
  }
}
