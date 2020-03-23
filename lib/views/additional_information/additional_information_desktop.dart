part of additional_information_view;

class _AdditionalInformationDesktop extends StatelessWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('AdditionalInformationDesktop')),
    );
  }
}