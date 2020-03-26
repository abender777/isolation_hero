part of leaderboard_view;

class _LeaderboardMobile extends StatefulWidget {
  final LeaderboardViewModel viewModel;

  _LeaderboardMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _LeaderboardMobileState(this.viewModel);
  }
}

class _LeaderboardMobileState extends State<_LeaderboardMobile> {
  final LeaderboardViewModel viewModel;

  _LeaderboardMobileState(this.viewModel);

  Widget body;

  @override
  void initState() {
    super.initState();
    this.viewModel.getLearderbords();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      body = Column(children: <Widget>[
        Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: getStatisticsListView(context),
              )
            ])),
      ]);
    });
    return MasterWidget(
        showDrawer: true, body: body, title: "MY STATS", showAppBar: true);
  }

  Column getStatisticsListView(BuildContext context) {
    List<Widget> result = new List<Widget>();
    if (this.viewModel.leaderboards != null) {
      for (int count = 0; count < this.viewModel.leaderboards.length; count++) {
        result.add(Container(
          decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.circular(8)),
            child: Row(children: <Widget>[
              SizedBox(width: 5),
              Column(children: <Widget>[
                CircleAvatar(child: Text((count + 1).toString(), overflow: TextOverflow.ellipsis))
              ]),
              SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.viewModel.leaderboards[count].name,
                        style: TextStyle(
                            color: Colors.amberAccent,
                            fontFamily: 'Monte',
                            fontSize: 20)),
                    Text(this.viewModel.leaderboards[count].pointsEarned,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Monte',
                            fontSize: 20)),
                    SizedBox(height: 10)
                  ])
            ])));
        result.add(SizedBox(height: 10));
      }
    }
    return Column(children: result);
  }
}
