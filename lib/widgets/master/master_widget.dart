library master_widget;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/earn_more_points/earn_more_points_view.dart';
import 'package:isolationhero/views/leaderboard/leaderboard_view.dart';
import 'package:isolationhero/widgets/drawer/drawer_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'master_mobile.dart';
part 'master_tablet.dart';
part 'master_desktop.dart';

class MasterWidget extends StatelessWidget {
  final bool showDrawer;
  final bool showAppBar;
  final Widget body;
  final String title;

  const MasterWidget({Key key, this.showDrawer, this.body, this.title, this.showAppBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _MasterMobile(showDrawer: showDrawer, body: body, title: title, showAppBar: showAppBar),
        desktop: _MasterDesktop(),
        tablet: _MasterTablet(),
    );
  }
}