import 'package:flutter/material.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar({
    Key key,
    Widget leading,
    Widget title,
    Widget flexibleSpace,
    bool centerTitle = true,
    List<Widget> actions,
    PreferredSizeWidget bottom,
  }) : super(
          key: key,
          title: title,
          leading: leading,
          flexibleSpace: flexibleSpace,
          centerTitle: centerTitle,
          backgroundColor: Colors.white,
          actions: actions,
          bottom: bottom,
        );
}
