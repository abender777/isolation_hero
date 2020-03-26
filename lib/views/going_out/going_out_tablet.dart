part of going_out_view;

class _GoingOutTablet extends StatelessWidget {
  final GoingOutViewModel viewModel;

  _GoingOutTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('GoingOutTablet')),
    );
  }
}