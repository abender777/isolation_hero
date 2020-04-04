library drawer_widget;

import 'package:avatar_glow/avatar_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:isolationhero/core/models/constants.dart';
import 'package:isolationhero/views/earn_more_points/earn_more_points_view.dart';
import 'package:isolationhero/views/going_out/going_out_view.dart';
import 'package:isolationhero/views/leaderboard/leaderboard_view.dart';
import 'package:isolationhero/views/my_leaderboard/my_leaderboard_view.dart';
import 'package:isolationhero/views/sign_in/sign_in_view.dart';
import 'package:isolationhero/views/user_profile/user_profile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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