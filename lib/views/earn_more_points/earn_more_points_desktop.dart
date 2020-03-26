part of earn_more_points_view;

class _EarnMorePointsDesktop extends StatelessWidget {
  final EarnMorePointsViewModel viewModel;

  _EarnMorePointsDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('EarnMorePointsDesktop')),
    );
  }
}