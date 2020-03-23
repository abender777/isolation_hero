part of additional_information_view;

class _AdditionalInformationMobile extends StatelessWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('AdditionalInformationMobile')),
    );
  }
}