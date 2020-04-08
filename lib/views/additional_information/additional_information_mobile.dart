part of additional_information_view;

class _AdditionalInformationMobile extends StatefulWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _AdditionalInformationState();
  }
}

enum Gender { male, female, other, not_to_say }

class _AdditionalInformationState extends State<_AdditionalInformationMobile> {
  Widget body;
  Gender _gender;
  List<String> _ageValues;

  @override
  void initState() {
    super.initState();
    _gender = Gender.male;
    _ageValues = List<String>();
    for (int count = 13; count <= 100; count++) {
      _ageValues.add(count.toString());
    }
  }

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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      SizedBox(width: 20),
                      Text("Age", style: TextStyle(color: Colors.white)),
                    ]),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.95,
                        // dropdown below..
                        child: new DropdownButton<String>(
                            items: _ageValues.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {}),
                      )
                    ])
                  ])),
          Column(
            children: <Widget>[
              ListTile(
                title:
                    const Text('Male', style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title:
                    const Text('Female', style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title:
                    const Text('Other', style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: Gender.other,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Prefer not to say',
                    style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: Gender.not_to_say,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
            ],
          ),
          ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 70.0,
              buttonColor: Theme.of(context).buttonColor,
              child: RaisedButton(
                onPressed: () {
                  locator<NavigatorService>().navigateToPageWithReplacement(
                      MaterialPageRoute(
                          builder: (context) => LocationSetupView()));
                },
                child:
                    Text('CONTINUE', style: Theme.of(context).textTheme.button),
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
                    locator<NavigatorService>().navigateToPageWithReplacement(
                        MaterialPageRoute(
                            builder: (context) => LocationSetupView()));
                  },
                  child: Text('NEVER MIND, SKIP THIS STEP',
                      style: Theme.of(context).textTheme.button),
                )))
      ]);
    });
    return MasterWidget(body: body);
  }
}
