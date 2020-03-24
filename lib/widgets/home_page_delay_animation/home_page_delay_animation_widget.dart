library home_page_delay_animation_widget;

import 'dart:async';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'home_page_delay_animation_mobile.dart';
part 'home_page_delay_animation_tablet.dart';
part 'home_page_delay_animation_desktop.dart';

class HomePageDelayAnimationWidget extends StatelessWidget {
  final Widget childWidget;
  final int delayInMillis;

  const HomePageDelayAnimationWidget({Key key, this.childWidget, this.delayInMillis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _HomePageDelayAnimationMobile(childWidget: childWidget, delayInMillis: delayInMillis),
        desktop: _HomePageDelayAnimationDesktop(),
        tablet: _HomePageDelayAnimationTablet(),
    );
  }
}