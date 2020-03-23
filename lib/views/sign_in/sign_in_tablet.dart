part of sign_in_view;

class _SignInTablet extends StatelessWidget {
  final SignInViewModel viewModel;

  _SignInTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SignInTablet')),
    );
  }
}