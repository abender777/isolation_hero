library leaderboard_view;

import 'package:isolationhero/widgets/master/master_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'leaderboard_view_model.dart';

part 'leaderboard_mobile.dart';
part 'leaderboard_tablet.dart';
part 'leaderboard_desktop.dart';

class LeaderboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LeaderboardViewModel viewModel = LeaderboardViewModel();
    return ViewModelProvider<LeaderboardViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _LeaderboardMobile(viewModel),
          desktop: _LeaderboardDesktop(viewModel),
          tablet: _LeaderboardTablet(viewModel),  
        );
      }
    );
  }
}