part of sign_in_view;

class _SignInDesktop extends StatelessWidget {
  final SignInViewModel viewModel;

  _SignInDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SignInDesktop')),
    );
  }
}