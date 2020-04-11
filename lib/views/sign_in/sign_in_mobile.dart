part of sign_in_view;

class _SignInMobile extends StatefulWidget {
  final SignInViewModel viewModel;

  _SignInMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _SignInMobileState(this.viewModel);
  }
}

class _SignInMobileState extends State<_SignInMobile> {
  final SignInViewModel viewModel;
  _SignInMobileState(this.viewModel);

  Widget body;
  String userNameOrEmail;
  String password;
  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      this.viewModel.login("", userNameOrEmail, password).then((result) {
        if (result != null && result) {
          locator<NavigatorService>().navigateToPageWithReplacement(
              MaterialPageRoute(builder: (context) => MyLeaderboardView()));
        } else {
          _showDialog(this.viewModel.loginError);
        }
      });
    }
  }

  void _showDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login Error!!"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      body = Stack(children: <Widget>[
        Form(
            key: _formKey,
            child: Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.all(5.0),
                      child: Row(children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: null),
                        Text("Sign In",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ])),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter user name or email';
                          }
                          return null;
                        },
                        controller: TextEditingController()
                          ..text =
                              userNameOrEmail != null ? userNameOrEmail : "",
                        onChanged: (String value) {
                          userNameOrEmail = value;
                        },
                        onSaved: (String value) {
                          userNameOrEmail = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Username OR Email',
                          prefixIcon: Icon(Icons.person),
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontFamily: 'Monte'),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).backgroundColor,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).buttonColor, width: 1),
                          ),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        controller: TextEditingController()
                          ..text = password != null ? password : "",
                        onChanged: (String value) {
                          password = value;
                        },
                        onSaved: (String value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(FontAwesomeIcons.eye),
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontFamily: 'Monte'),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).backgroundColor,
                                width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).buttonColor, width: 1),
                          ),
                        ),
                      ))
                ]))),
          Align(
          alignment: FractionalOffset.bottomCenter,
          child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 70.0,
              buttonColor: Theme.of(context).buttonColor,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    body = Center(child: CircularProgressIndicator());
                  });
                  submit();
                },
                child: Text('LOGIN', style: Theme.of(context).textTheme.button),
              )),
        ),
      ]);
    });
    return MasterWidget(body: body);
  }
}
