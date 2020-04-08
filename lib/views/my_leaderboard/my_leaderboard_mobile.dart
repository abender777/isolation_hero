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
    this.viewModel.getUserStats();
    this.viewModel.getUserDailyStats();
    this.viewModel.getTotalEvents();
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
    return MasterWidget(
        showDrawer: true, body: body, title: "MY STATS", showAppBar: true);
  }

  List<Widget> getStatisticsListView(BuildContext context) {
    List<Widget> result = new List<Widget>();
    if (this.viewModel.userStats != null) {
      for (int count = 0; count < this.viewModel.userStats.length; count++) {
        result.add(Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(44, 74, 104, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(this.viewModel.userStats[count].count,
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'Monte',
                        fontSize: 50)),
                Text(this.viewModel.userStats[count].name,
                    style: TextStyle(
                        color: Color.fromRGBO(13, 169, 196, 1),
                        fontFamily: 'Monte',
                        fontSize: 30))
              ],
            )));
        result.add(SizedBox(width: 20));
      }
    }
    return result;
  }

  List<Widget> getDaywiseScoreListView(BuildContext context) {
    List<Widget> result = new List<Widget>();
    if (this.viewModel.userDailyStats != null) {
      for (int count = 0;
          count < this.viewModel.userDailyStats.length;
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
                Text(this.viewModel.userDailyStats[count].dayName.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 25)),
                Text(this.viewModel.userDailyStats[count].day.toString(),
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'Monte',
                        fontSize: 45)),
                Text(this.viewModel.userDailyStats[count].monthName.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 25)),
                Text(
                    this
                            .viewModel
                            .userDailyStats[count]
                            .percentageScore
                            .toString() +
                        "%",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 30)),
                Text(
                    this.viewModel.userDailyStats[count].status == 1
                        ? "OK"
                        : "",
                    style: TextStyle(
                        color: this.viewModel.userDailyStats[count].status == 1
                            ? Colors.green
                            : Colors.white,
                        fontFamily: 'Monte',
                        fontSize: 30))
              ],
            )));
        result.add(SizedBox(width: 20));
      }
    }
    return result;
  }
}
