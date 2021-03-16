import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_pm_flutter/model/contact.dart';
import 'package:simple_pm_flutter/provider/contact_provider.dart';
import 'package:simple_pm_flutter/widgets/avatar.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  final TextEditingController _emailController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  int _currentIndex = 0;


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
    return Consumer<ContactProvider>(
        builder: (context, contactProvider, _) {
          List<ContactData>  contactList = contactProvider.contactList;
          return Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Avatar("assets/images/avatar-default.jpg"),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60,
                                  child: Text(contactList[index].foreignName),
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom:BorderSide(width: 1,color: Color(0xffe5e5e5)))
                                  ),
                                )
                            )
                          ],
                        );
                      },
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                     ),
                  Align(
                    alignment: new FractionalOffset(1.0, 0.5),
                    child: SizedBox(
                      width: 25,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: contactProvider.letters.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Text(
                                contactProvider.letters[index],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _currentIndex = index;
                                });
                                var height = index * 45.0;
                                for (int i = 0; i < index; i++) {
                                  // height += data[i].listData.length * 46.0;
                                }
                                _scrollController.jumpTo(height);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )

              );
        }
    );
  }
}
