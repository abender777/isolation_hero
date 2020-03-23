part of sign_in_view;

class _SignInMobile extends StatelessWidget {
  final SignInViewModel viewModel;

  _SignInMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SignInMobile')),
    );
  }
}