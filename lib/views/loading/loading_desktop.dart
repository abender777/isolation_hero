part of loading_view;

class _LoadingDesktop extends StatelessWidget {
  final LoadingViewModel viewModel;

  _LoadingDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LoadingDesktop')),
    );
  }
}