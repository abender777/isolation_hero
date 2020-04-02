library introduction_view;

import 'package:introduction_screen/introduction_screen.dart';
import 'package:isolationhero/views/my_leaderboard/my_leaderboard_view.dart';
import 'package:isolationhero/views/sign_up/sign_up_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'introduction_view_model.dart';

part 'introduction_mobile.dart';
part 'introduction_tablet.dart';
part 'introduction_desktop.dart';

class IntroductionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IntroductionViewModel viewModel = IntroductionViewModel();
    return ViewModelProvider<IntroductionViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _IntroductionMobile(viewModel),
          desktop: _IntroductionDesktop(viewModel),
          tablet: _IntroductionTablet(viewModel),  
        );
      }
    );
  }
}