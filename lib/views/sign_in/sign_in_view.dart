library sign_in_view;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isolationhero/views/my_leaderboard/my_leaderboard_view.dart';
import 'package:isolationhero/widgets/master/master_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'sign_in_view_model.dart';

part 'sign_in_mobile.dart';
part 'sign_in_tablet.dart';
part 'sign_in_desktop.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignInViewModel viewModel = SignInViewModel();
    return ViewModelProvider<SignInViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _SignInMobile(viewModel),
          desktop: _SignInDesktop(viewModel),
          tablet: _SignInTablet(viewModel),  
        );
      }
    );
  }
}