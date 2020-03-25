library my_leaderboard_view;

import 'package:isolationhero/widgets/master/master_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'my_leaderboard_view_model.dart';

part 'my_leaderboard_mobile.dart';
part 'my_leaderboard_tablet.dart';
part 'my_leaderboard_desktop.dart';

class MyLeaderboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyLeaderboardViewModel viewModel = MyLeaderboardViewModel();
    return ViewModelProvider<MyLeaderboardViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _MyLeaderboardMobile(viewModel),
          desktop: _MyLeaderboardDesktop(viewModel),
          tablet: _MyLeaderboardTablet(viewModel),  
        );
      }
    );
  }
}