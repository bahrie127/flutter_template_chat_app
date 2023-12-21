import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, this.radius}) : super(key: key);

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      radius: radius,
      child: Icon(Icons.person, size: radius),
    );
  }
}
