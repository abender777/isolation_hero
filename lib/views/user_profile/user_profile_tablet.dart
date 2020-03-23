part of user_profile_view;

class _UserProfileTablet extends StatelessWidget {
  final UserProfileViewModel viewModel;

  _UserProfileTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('UserProfileTablet')),
    );
  }
}