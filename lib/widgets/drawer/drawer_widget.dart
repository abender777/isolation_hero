library drawer_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'drawer_mobile.dart';
part 'drawer_tablet.dart';
part 'drawer_desktop.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _DrawerMobile(),
        desktop: _DrawerDesktop(),
        tablet: _DrawerTablet(),
    );
  }
}