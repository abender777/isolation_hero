part of introduction_view;

class _IntroductionTablet extends StatelessWidget {
  final IntroductionViewModel viewModel;

  _IntroductionTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('IntroductionTablet')),
    );
  }
}