part of user_profile_view;

class _UserProfileDesktop extends StatelessWidget {
  final UserProfileViewModel viewModel;

  _UserProfileDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('UserProfileDesktop')),
    );
  }
}