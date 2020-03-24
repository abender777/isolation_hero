library additional_information_view;

import 'package:isolationhero/views/location_setup/location_setup_view.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'additional_information_view_model.dart';

part 'additional_information_mobile.dart';
part 'additional_information_tablet.dart';
part 'additional_information_desktop.dart';

class AdditionalInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdditionalInformationViewModel viewModel = AdditionalInformationViewModel();
    return ViewModelProvider<AdditionalInformationViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _AdditionalInformationMobile(viewModel),
          desktop: _AdditionalInformationDesktop(viewModel),
          tablet: _AdditionalInformationTablet(viewModel),  
        );
      }
    );
  }
}