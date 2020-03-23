part of introduction_view;

class _IntroductionDesktop extends StatelessWidget {
  final IntroductionViewModel viewModel;

  _IntroductionDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('IntroductionDesktop')),
    );
  }
}
