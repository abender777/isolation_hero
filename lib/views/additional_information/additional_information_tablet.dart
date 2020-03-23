part of additional_information_view;

class _AdditionalInformationTablet extends StatelessWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('AdditionalInformationTablet')),
    );
  }
}