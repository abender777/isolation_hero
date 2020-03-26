part of going_out_view;

class _GoingOutDesktop extends StatelessWidget {
  final GoingOutViewModel viewModel;

  _GoingOutDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('GoingOutDesktop')),
    );
  }
}