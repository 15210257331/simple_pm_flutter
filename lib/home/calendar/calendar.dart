import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion(
            value: SystemUiOverlayStyle.light,
            child: Container(
              color: Colors.greenAccent,
            )
        )
    );
  }
}
