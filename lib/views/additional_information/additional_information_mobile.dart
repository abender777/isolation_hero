part of additional_information_view;

class _AdditionalInformationMobile extends StatefulWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _AdditionalInformationState(this.viewModel);
  }
}

enum Gender { male, female, other, not_to_say }

class _AdditionalInformationState extends State<_AdditionalInformationMobile> {
  final AdditionalInformationViewModel viewModel;
  _AdditionalInformationState(this.viewModel);

  Widget body;
  Gender _gender;
  List<String> _ageValues;
  int _selectedGender;
  String _selectedAge;

  @override
  void initState() {
    super.initState();
    _gender = Gender.not_to_say;
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
                    SizedBox(height: 10),
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
                            hint: Text("Age", style: TextStyle(color: Colors.white)),
                            focusColor: Colors.white,
                            value: _selectedAge,
                            items: _ageValues.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value.toString(),
                                child: new Text(value, style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedAge = newValue;
                              });
                            }),
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
                      _selectedGender = 1;
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
                      _selectedGender = 2;
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
                      _selectedGender = 3;
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
                      _selectedGender = 4;
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
                  if(_selectedAge!=null && _selectedGender!=null){
                    this.viewModel.saveUserProfile(_selectedAge.toString(), _selectedGender.toString());
                  }
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
