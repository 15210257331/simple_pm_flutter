import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_pm_flutter/pages/mine/setting.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion(
            value: SystemUiOverlayStyle.dark,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  _buildCard(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('苏大强',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('ID: 1250',
                    style: TextStyle(
                        color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _buildSet()
                ],
              ),
            )
        )
    );
  }

  Widget _buildCard() {
    return Card(
      color: Theme.of(context).primaryColor,
      //z轴的高度，设置card的阴影
      elevation:10.0,
      //设置shape，这里设置成了R角
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60)),),
      //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
      clipBehavior: Clip.antiAlias,
      semanticContainer: false,
      child: Container(
        color: Theme.of(context).primaryColor,
        width: 120,
        height: 120,
        alignment: Alignment.center,
        child: Text(
          "大强",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      )
    );
  }

  Widget _buildSet() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom:BorderSide(width: 1,color: Color(0xffe5e5e5)),
          top:BorderSide(width: 1,color: Color(0xffe5e5e5))
        )
      ),
      child: ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Setting(),
            ));
          },
      )
    );
  }
}

