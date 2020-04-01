part of loading_view;

class _LoadingTablet extends StatelessWidget {
  final LoadingViewModel viewModel;

  _LoadingTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LoadingTablet')),
    );
  }
}