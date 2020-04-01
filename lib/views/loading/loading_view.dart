library loading_view;

import 'package:avatar_glow/avatar_glow.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'loading_view_model.dart';

part 'loading_mobile.dart';
part 'loading_tablet.dart';
part 'loading_desktop.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoadingViewModel viewModel = LoadingViewModel();
    return ViewModelProvider<LoadingViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _LoadingMobile(viewModel),
          desktop: _LoadingDesktop(viewModel),
          tablet: _LoadingTablet(viewModel),  
        );
      }
    );
  }
}