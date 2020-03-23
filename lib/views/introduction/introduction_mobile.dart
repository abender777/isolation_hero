part of introduction_view;

class _IntroductionMobile extends StatelessWidget {
  final IntroductionViewModel viewModel;

  _IntroductionMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('IntroductionMobile')),
    );
  }
}
