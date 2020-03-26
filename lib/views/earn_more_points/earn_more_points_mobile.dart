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
                child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 70.0,
                    buttonColor: Color.fromRGBO(44, 74, 104, 1),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('READ THIS LINK AND EARN MORE POINTS',
                          style: Theme.of(context).textTheme.button),
                    )),
              )
            ])),
      ]);
    });
    return MasterWidget(
        showDrawer: true,
        body: body,
        title: "EARN MORE POINTS",
        showAppBar: true);
  }
}
