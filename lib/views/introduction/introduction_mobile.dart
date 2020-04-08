part of introduction_view;

class _IntroductionMobile extends StatefulWidget {
  final IntroductionViewModel viewModel;

  _IntroductionMobile(this.viewModel);

  @override
  _IntroductionPageState createState() =>
      _IntroductionPageState(this.viewModel);
}

class _IntroductionPageState extends State<_IntroductionMobile> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final IntroductionViewModel viewModel;

  _IntroductionPageState(this.viewModel);

  Widget body;

  @override
  void initState() {
    super.initState();
    this.viewModel.getInstructions();
    this.viewModel.isIntroductionSeenByUser();
    this.viewModel.verifyUserToken();
  }

  void _onIntroEnd(context) {
    this.viewModel.setIntroductionComplete();
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignUpView()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  List<PageViewModel> getInstructionsPages() {
    List<PageViewModel> result = new List<PageViewModel>();
    if (this.viewModel.instructions != null) {
      const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.white);
      const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        imagePadding: EdgeInsets.zero,
      );

      for (int count = 0; count < this.viewModel.instructions.length; count++) {
        result.add(PageViewModel(
            title: "",
            body: this.viewModel.instructions[count].description,
            image: SvgPicture.network(
              this.viewModel.instructions[count].imageUrl,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator()),
            ),
            decoration: pageDecoration));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (this.viewModel.isTokenValid == null) {
      setState(() {
        body = Center(child: CircularProgressIndicator());
      });
    }

    if (this.viewModel.isTokenValid != null && this.viewModel.isTokenValid) {
      setState(() {
        body = MyLeaderboardView();
      });
    }
    if (this.viewModel.isTokenValid != null && !this.viewModel.isTokenValid) {
      setState(() {
        body = SignUpView();
      });
    }
    if (this.viewModel.isIntroSeen != null && !this.viewModel.isIntroSeen) {
      setState(() {
        body = IntroductionScreen(
          key: introKey,
          pages: getInstructionsPages(),
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          skip: const Text('Skip', style: TextStyle(color: Colors.white)),
          next: const Icon(Icons.arrow_forward, color: Colors.white),
          done:
              const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.white,
            activeSize: Size(22.0, 10.0),
            activeColor: Colors.amber,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        );
      });
    }

    return body;
  }
}
