part of location_setup_view;

class _LocationSetupMobile extends StatefulWidget {
  final LocationSetupViewModel viewModel;
  _LocationSetupMobile(this.viewModel);

  _LocationSetupMobileState createState() =>
      new _LocationSetupMobileState(this.viewModel);
}

class _LocationSetupMobileState extends State<_LocationSetupMobile> {
  final LocationSetupViewModel viewModel;

  _LocationSetupMobileState(this.viewModel);
  Widget mapWidget;

  @override
  void initState() {
    super.initState();
    this.viewModel.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (this.viewModel.position != null) {
      setState(() {
        mapWidget = new Stack(children: <Widget>[
          new FlutterMap(
            options: new MapOptions(
              center: new LatLng(this.viewModel.position.latitude,
                  this.viewModel.position.longitude),
              zoom: 13.0,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 80.0,
                    height: 80.0,
                    point: new LatLng(this.viewModel.position.latitude,
                        this.viewModel.position.longitude),
                    builder: (ctx) => new Container(
                      child: Icon(
                        Icons.person_pin_circle,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(5.0),
              child: Row(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Theme.of(context).buttonColor),
                    onPressed: null),
                Text("Set Home Location",
                    style: TextStyle(
                        color: Theme.of(context).buttonColor, fontSize: 28)),
              ])),
          Container(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Wrap(
                          children: <Widget>[
                            Text(
                                this.viewModel.address != null
                                    ? this.viewModel.address
                                    : "",
                                style: TextStyle(
                                    color: Theme.of(context).buttonColor,
                                    fontSize: 15))
                          ],
                        )),
                    ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 70.0,
                        buttonColor: Theme.of(context).buttonColor,
                        child: RaisedButton(
                          onPressed: () {
                            this
                                .viewModel
                                .setLocation(this.viewModel.userLocation)
                                .then((onValue) {
                              if (onValue != null && onValue) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyLeaderboardView(),
                                  ),
                                );
                              }
                            });
                          },
                          child: Text('CONTINUE',
                              style: Theme.of(context).textTheme.button),
                        )),
                  ]))
        ]);
      });
    } else {
      setState(() {
        mapWidget = Center(child: CircularProgressIndicator());
      });
    }
    return MasterWidget(body: mapWidget, showAppBar: false, showDrawer: false);
  }
}
