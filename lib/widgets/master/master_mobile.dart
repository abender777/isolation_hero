part of master_widget;

class _MasterMobile extends StatelessWidget {
  final bool showDrawer;
  final bool showAppBar;
  final Widget body;
  final String title;

  const _MasterMobile(
      {Key key, this.showDrawer, this.body, this.title, this.showAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.showAppBar != null && this.showAppBar) {
      return MaterialApp(
          theme: lightTheme,
          home: new Stack(children: <Widget>[
            Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  title: Text(title != null ? title : "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: 'Monte')),
                  elevation: 0.0,
                  centerTitle: true,
                ),
                backgroundColor: Theme.of(context).backgroundColor,
                resizeToAvoidBottomInset: false,
                body: buildBody(context, body),
                drawer: DrawerWidget())
          ]));
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: body,
      );
    }
  }

  Column buildBody(BuildContext context, body) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: new EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                  child: new Container(
                      padding: new EdgeInsets.only(left: 5, right: 5),
                      child: new Center(
                          child: new Column(children: <Widget>[body]))))),
        ),
        bottomNavigationBar(context),
      ],
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Container(
        color: Theme.of(context).buttonColor,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.sortNumericUpAlt,
                        color: Colors.amber),
                    onPressed: () {
                      locator<NavigatorService>().navigateToPageWithReplacement(
                          MaterialPageRoute(
                              builder: (context) => MyLeaderboardView()));
                    },
                    padding: EdgeInsets.only(bottom: 0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("MY STATS",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Monte',
                          fontSize: 10)),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.trophy, color: Colors.amber),
                    onPressed: () {
                      locator<NavigatorService>().navigateToPageWithReplacement(
                          MaterialPageRoute(
                              builder: (context) => LeaderboardView()));
                    },
                    padding: EdgeInsets.only(bottom: 0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("LEADERBOARD",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Monte',
                          fontSize: 10)),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.running, color: Colors.amber),
                    onPressed: () {
                      locator<NavigatorService>().navigateToPageWithReplacement(MaterialPageRoute(
                              builder: (context) => GoingOutView()));
                    },
                    padding: EdgeInsets.only(bottom: 0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("GOING OUT",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Monte',
                          fontSize: 10)),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon:
                        Icon(FontAwesomeIcons.plusCircle, color: Colors.amber),
                    onPressed: () {
                            locator<NavigatorService>().navigateToPageWithReplacement(MaterialPageRoute(
                              builder: (context) => EarnMorePointsView()));
                    },
                    padding: EdgeInsets.only(bottom: 0),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text("BONUS POINTS",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Monte',
                          fontSize: 10)),
                ],
              )
            ],
          )
        ]));
  }
}
