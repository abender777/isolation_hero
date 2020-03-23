library user_profile_view;

import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'user_profile_view_model.dart';

part 'user_profile_mobile.dart';
part 'user_profile_tablet.dart';
part 'user_profile_desktop.dart';

class UserProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProfileViewModel viewModel = UserProfileViewModel();
    return ViewModelProvider<UserProfileViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _UserProfileMobile(viewModel),
          desktop: _UserProfileDesktop(viewModel),
          tablet: _UserProfileTablet(viewModel),  
        );
      }
    );
  }
}