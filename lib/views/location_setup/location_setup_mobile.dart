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
        mapWidget = Scaffold(
            body: new Stack(children: <Widget>[
          new FlutterMap(
            options: new MapOptions(
              center: new LatLng(18.5764, 73.9940),
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
                    point: new LatLng(18.5764, 73.9940),
                    builder: (ctx) => new Container(
                      child: new FlutterLogo(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height: 70.0,
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.blue)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyLeaderboardView(),
                  ),
                );
              },
              child:
                  Text('CONTINUE', style: Theme.of(context).textTheme.button),
            ),
          ))
        ]));
      });
    } else {
      mapWidget = Scaffold(body: CircularProgressIndicator());
    }
    return mapWidget;
  }
}
