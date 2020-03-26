part of earn_more_points_view;

class _EarnMorePointsTablet extends StatelessWidget {
  final EarnMorePointsViewModel viewModel;

  _EarnMorePointsTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('EarnMorePointsTablet')),
    );
  }
}