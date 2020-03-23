part of location_setup_view;

class _LocationSetupMobile extends StatelessWidget {
  final LocationSetupViewModel viewModel;

  _LocationSetupMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LocationSetupMobile')),
    );
  }
}