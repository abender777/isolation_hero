part of sign_up_view;

class _SignUpMobile extends StatelessWidget {
  final SignUpViewModel viewModel;

  _SignUpMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SignUpMobile')),
    );
  }
}