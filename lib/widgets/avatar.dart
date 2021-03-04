import 'package:flutter/material.dart';

///头像处理类
class Avatar extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final double padding;
  final BoxShape boxShape;
  final double radius;
  final Color boxBroadColor;

  Avatar(
      this.imgUrl, {
        this.width = 50,
        this.height = 50,
        this.padding = 0,
        this.boxShape = BoxShape.circle,
        this.radius = 0,
        this.boxBroadColor = Colors.white,
      });

  @override
  Widget build(BuildContext context) {

    _getChildWidget() {
      return boxShape == BoxShape.circle
          ? CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      )
          : ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
        ),
      );
    }
    _getBorderRadius(){
      return boxShape == BoxShape.circle
          ? BoxDecoration(
        shape: boxShape,
        color: boxBroadColor,
      )
          : BoxDecoration(
        shape: boxShape,
        color: boxBroadColor,
        borderRadius: BorderRadius.circular(radius),
      );
    }
    return Container(
        width: width,
        height: height,
        child: _getChildWidget(),
        padding: EdgeInsets.all(padding),
        decoration:_getBorderRadius());
  }
}