library going_out_view;

import 'package:isolationhero/widgets/master/master_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'going_out_view_model.dart';

part 'going_out_mobile.dart';
part 'going_out_tablet.dart';
part 'going_out_desktop.dart';

class GoingOutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoingOutViewModel viewModel = GoingOutViewModel();
    return ViewModelProvider<GoingOutViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _GoingOutMobile(viewModel),
          desktop: _GoingOutDesktop(viewModel),
          tablet: _GoingOutTablet(viewModel),  
        );
      }
    );
  }
}