library earn_more_points_view;

import 'package:isolationhero/widgets/master/master_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'earn_more_points_view_model.dart';

part 'earn_more_points_mobile.dart';
part 'earn_more_points_tablet.dart';
part 'earn_more_points_desktop.dart';

class EarnMorePointsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EarnMorePointsViewModel viewModel = EarnMorePointsViewModel();
    return ViewModelProvider<EarnMorePointsViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _EarnMorePointsMobile(viewModel),
          desktop: _EarnMorePointsDesktop(viewModel),
          tablet: _EarnMorePointsTablet(viewModel),  
        );
      }
    );
  }
}