part of earn_more_points_view;

class _EarnMorePointsMobile extends StatefulWidget {
  final EarnMorePointsViewModel viewModel;

  _EarnMorePointsMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _EarnMorePointsMobileState(this.viewModel);
  }
}

class _EarnMorePointsMobileState extends State<_EarnMorePointsMobile> {
  final EarnMorePointsViewModel viewModel;

  _EarnMorePointsMobileState(this.viewModel);

  Widget body;

  @override
  void initState() {
    super.initState();
    this.viewModel.getBonusPointLinks();
  }

  @override
  Widget build(BuildContext context) {
    if (this.viewModel.noDataFound == null) {
      setState(() {
        body = Center(child: CircularProgressIndicator());
      });
    }

    if (this.viewModel.noDataFound != null && !this.viewModel.noDataFound) {
      setState(() {
        body = Column(children: getLinks());
      });
    }

    if (this.viewModel.noDataFound != null && this.viewModel.noDataFound) {
      setState(() {
        body = Container(
            child: Text(
                "Seems like you have earned all bonus points!! We will add new link soon, Stay connected!! Stay Isolated!! Stay Safe!!", style: TextStyle(color: Colors.white)));
      });
    }
    return MasterWidget(
        showDrawer: true,
        body: body,
        title: "EARN MORE POINTS",
        showAppBar: true);
  }

  List<Widget> getLinks() {
    List<Widget> result = new List<Widget>();

    if (this.viewModel.bonusPointLinks != null) {
      for (int count = 0;
          count < this.viewModel.bonusPointLinks.length;
          count++) {
        // result.add(Text(this.viewModel.bonusPointLinks[count].name));
        // result.add(Text(this.viewModel.bonusPointLinks[count].description));
        result.add(Container(
            padding: EdgeInsets.all(5),
            decoration: new BoxDecoration(
              color: Theme.of(context).buttonColor,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(this.viewModel.bonusPointLinks[count].name,
                      style:
                          TextStyle(color: Colors.amberAccent, fontSize: 25)),
                  SizedBox(height: 10),
                  Text(this.viewModel.bonusPointLinks[count].description,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          child: ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 70.0,
                              buttonColor: Theme.of(context).backgroundColor,
                              child: RaisedButton(
                                onPressed: () {
                                  this.viewModel.setLinkClickedByUser(this
                                      .viewModel
                                      .bonusPointLinks[count]
                                      .id
                                      .toString());
                                  _launchURL(this
                                      .viewModel
                                      .bonusPointLinks[count]
                                      .link);
                                },
                                child: Text('CLICK TO EARN MORE POINTS',
                                    style: TextStyle(color: Colors.amber)),
                              )),
                        )
                      ]))
                ])));
        result.add(SizedBox(height: 20));
      }
    }
    return result;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
