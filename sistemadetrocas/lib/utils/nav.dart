import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

push(BuildContext context, Widget page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    ),
  );
}

pop(BuildContext context) {
  return Navigator.pop(context);
}
