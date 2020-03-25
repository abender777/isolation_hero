part of additional_information_view;

class _AdditionalInformationMobile extends StatefulWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _AdditionalInformationState();
  }
}

class _AdditionalInformationState extends State<_AdditionalInformationMobile> {
  Widget body;

  @override
  Widget build(BuildContext context) {
    setState(() {
      body = Stack(children: <Widget>[
        Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(5.0),
              child: Row(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: null),
                Text("Personal Information",
                    style: TextStyle(color: Colors.white, fontSize: 28)),
              ])),
          Container(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'Date Of Birth',
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor, fontFamily: 'Monte'),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).backgroundColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).buttonColor, width: 1),
                  ),
                ),
              )),
          Container(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'Gender',
                  prefixIcon: Icon(Icons.email),
                  hintStyle: TextStyle(
                      color: Theme.of(context).hintColor, fontFamily: 'Monte'),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).backgroundColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).buttonColor, width: 1),
                  ),
                ),
              )),
        ]),
        Align(
            alignment: FractionalOffset.bottomCenter,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 70.0,
              buttonColor: Theme.of(context).buttonColor,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationSetupView(),
                    ),
                  );
                },
                child:
                    Text('CONTINUE', style: Theme.of(context).textTheme.button),
              ),
            ))
      ]);
    });
    return MasterWidget(body: body);
  }
}
