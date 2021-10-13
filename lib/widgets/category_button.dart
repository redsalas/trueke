import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Icon icon;
  final String message;
  final Color color;
  final double width;
  final double height;
  final Color splashColor;
  final Function onTap;

  const CategoryButton({
    Key key,
    @required this.icon,
    @required this.message,
    this.color = Colors.blue,
    this.splashColor = Colors.redAccent,
    this.width = 56,
    this.height = 56,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: splashColor,
            onTap: () => Navigator.pushNamed(context, '/post_category', arguments: message),
            child: SizedBox(
              width: width,
              height: height,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}