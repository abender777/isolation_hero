part of location_setup_view;

class _LocationSetupTablet extends StatelessWidget {
  final LocationSetupViewModel viewModel;

  _LocationSetupTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LocationSetupTablet')),
    );
  }
}