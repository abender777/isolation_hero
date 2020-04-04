part of going_out_view;

class _GoingOutMobile extends StatefulWidget {
  final GoingOutViewModel viewModel;

  _GoingOutMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _GoingOutMobileState(this.viewModel);
  }
}

class _GoingOutMobileState extends State<_GoingOutMobile> {
  final GoingOutViewModel viewModel;
  _GoingOutMobileState(this.viewModel);

  Widget body;
  String movementReasonId;
  int backInMinutes;
  String _selectedReason;  
  String _selectedTime;
  
  @override
  void initState() {
    super.initState();
    this.viewModel.getMovementReasons();
    this.viewModel.getBackInTimes();
  }

  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      this
          .viewModel
          .addMovementReason(movementReasonId, backInMinutes)
          .then((result) {
        if (result != null && result) {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyLeaderboardView()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.viewModel.movementReasons != null &&
        this.viewModel.backInTime != null) {
      setState(() {
        body = Stack(children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).buttonColor,
                                    borderRadius: BorderRadius.circular(10),
                                    ),
                                width: MediaQuery.of(context).size.width * 0.93,
                                // dropdown below..
                                child: new DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Select Reason", style: TextStyle(color: Colors.white)),
                                  focusColor: Colors.white,
                                  value: _selectedReason,
                                    items: this
                                        .viewModel
                                        .movementReasons
                                        .map((MovementReason movementReason) {
                                      return new DropdownMenuItem<String>(
                                        value: movementReason.id.toString(),
                                        child: new Text(movementReason.name, style: TextStyle(color: Colors.white)),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        movementReasonId = newValue;
                                        _selectedReason = newValue;
                                      });
                                    }),
                              )
                            ])
                          ])),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).buttonColor,
                                    borderRadius: BorderRadius.circular(10)),
                                width: MediaQuery.of(context).size.width * 0.93,
                                // dropdown below..
                                child: new DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Back In"),
                                    value: _selectedTime,
                                    items: this
                                        .viewModel
                                        .backInTime
                                        .map((BackInTime backInTime) {
                                      return new DropdownMenuItem<String>(
                                        value:
                                            backInTime.timeInMinutes.toString(),
                                        child: new Text(backInTime.name, style: TextStyle(color: Colors.white)),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        backInMinutes = int.parse(newValue);
                                        _selectedTime = newValue;
                                      });
                                    }),
                              )
                            ])
                          ])),
                  ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 70.0,
                      buttonColor: Theme.of(context).buttonColor,
                      child: RaisedButton(
                        onPressed: () {
                          submit();
                        },
                        child: Text('SUBMIT',
                            style: Theme.of(context).textTheme.button),
                      ))
                ])),
          )
        ]);
      });
    } else {
      setState(() {
        body = Center(child: CircularProgressIndicator());
      });
    }
    return MasterWidget(
        showDrawer: true, body: body, title: "GOING OUT", showAppBar: true);
  }
}
