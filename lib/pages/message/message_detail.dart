import 'package:flutter/material.dart';

class MessageDetail extends StatefulWidget {
  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('zhangsan'),
        elevation: 0,
      ),
      body: Container(
        // color: Colors.red,
      ),
    );
  }
}