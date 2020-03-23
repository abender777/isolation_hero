part of location_setup_view;

class _LocationSetupDesktop extends StatelessWidget {
  final LocationSetupViewModel viewModel;

  _LocationSetupDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LocationSetupDesktop')),
    );
  }
}