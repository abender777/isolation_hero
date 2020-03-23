part of user_profile_view;

class _UserProfileMobile extends StatelessWidget {
  final UserProfileViewModel viewModel;

  _UserProfileMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('UserProfileMobile')),
    );
  }
}