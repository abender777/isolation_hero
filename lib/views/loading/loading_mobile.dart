part of loading_view;

class _LoadingMobile extends StatelessWidget {
  final LoadingViewModel viewModel;

  _LoadingMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AvatarGlow(
      endRadius: 60,
      duration: Duration(seconds: 2),
      glowColor: Colors.white24,
      repeat: true,
      repeatPauseDuration: Duration(seconds: 2),
      startDelay: Duration(seconds: 1),
      child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Image(image: ExactAssetImage("assets/ih.png")),
            radius: 30.0,
          )),
    )));
  }
}
