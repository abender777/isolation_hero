library time_counter_widget;

import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'time_counter_mobile.dart';
part 'time_counter_tablet.dart';
part 'time_counter_desktop.dart';

class TimeCounterWidget extends StatelessWidget {
  final int secondsRemaining;

  const TimeCounterWidget({Key key, this.secondsRemaining}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _TimeCounterMobile(secondsRemaining: this.secondsRemaining),
        desktop: _TimeCounterDesktop(),
        tablet: _TimeCounterTablet(),
    );
  }
}