library location_setup_view;

import 'package:isolationhero/views/my_leaderboard/my_leaderboard_view.dart';
import 'package:isolationhero/widgets/master/master_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'location_setup_view_model.dart';


part 'location_setup_mobile.dart';
part 'location_setup_tablet.dart';
part 'location_setup_desktop.dart';

class LocationSetupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocationSetupViewModel viewModel = LocationSetupViewModel();
    return ViewModelProvider<LocationSetupViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _LocationSetupMobile(viewModel),
          desktop: _LocationSetupDesktop(viewModel),
          tablet: _LocationSetupTablet(viewModel),  
        );
      }
    );
  }
}