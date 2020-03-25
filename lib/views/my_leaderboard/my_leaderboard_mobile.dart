part of my_leaderboard_view;

class _MyLeaderboardMobile extends StatefulWidget {
  final MyLeaderboardViewModel viewModel;

  _MyLeaderboardMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _MyLeaderboardState(this.viewModel);
  }
}

class _MyLeaderboardState extends State<_MyLeaderboardMobile> {
  final MyLeaderboardViewModel viewModel;

  _MyLeaderboardState(this.viewModel);

  Widget body;

  @override
  void initState() {
    super.initState();
    this.viewModel.getLearderbordStats();
    this.viewModel.getLearderbordDailyStats();
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
                      height: 150.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: getStatisticsListView(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 230.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: getDaywiseScoreListView(context),
                      ),
                    ),
                  ])),
            ]); 
    });
    return MasterWidget(showDrawer: true, body: body, title: "MY STATS", showAppBar: true);
  }

  List<Widget> getStatisticsListView(BuildContext context) {
    List<Widget> result = new List<Widget>();
    if (this.viewModel.learderbordStats != null) {
      for (int count = 0;
          count < this.viewModel.learderbordStats.length;
          count++) {
        result.add(Container(
            width: 160.0,
            decoration: BoxDecoration(
                color: Color.fromRGBO(44, 74, 104, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(this.viewModel.learderbordStats[count].count,
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'Monte',
                        fontSize: 50)),
                Text(this.viewModel.learderbordStats[count].name,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Monte', fontSize: 30))
              ],
            )));
        result.add(SizedBox(width: 20));
      }
    }
    return result;
  }

  List<Widget> getDaywiseScoreListView(BuildContext context) {
    List<Widget> result = new List<Widget>();
    if (this.viewModel.learderbordDailyStats != null) {
      for (int count = 0;
          count < this.viewModel.learderbordDailyStats.length;
          count++) {
        result.add(Container(
            width: 160.0,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(44, 74, 104, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(this.viewModel.learderbordDailyStats[count].day,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 25)),
                Text(this.viewModel.learderbordDailyStats[count].date,
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'Monte',
                        fontSize: 45)),
                Text(this.viewModel.learderbordDailyStats[count].month,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 25)),
                Text(
                    this.viewModel.learderbordDailyStats[count].percentage +
                        "%",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 30)),
                Text(
                    this
                        .viewModel
                        .learderbordDailyStats[count]
                        .status
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Monte', fontSize: 30))
              ],
            )));
        result.add(SizedBox(width: 20));
      }
    }
    return result;
  }
}
