part of sign_up_view;

class _SignUpMobile extends StatefulWidget {
  final SignUpViewModel viewModel;

  _SignUpMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _SignUpMobileState(this.viewModel);
  }
}

class _SignUpMobileState extends State<_SignUpMobile> {
  final SignUpViewModel viewModel;
  _SignUpMobileState(this.viewModel);
  Widget body;

  String userName;
  String email;
  String password;

  final _formKey = GlobalKey<FormState>();

  void submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      this.viewModel.register(userName, email, password).then((result) {
        if (result != null && result) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LocationSetupView()));
        } else {
          SnackBar(
            content: Text(this.viewModel.loginError));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //return MasterWidget(showDrawer: true, body: body, title: "My Stats");
    setState(() {
      body = Container(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AvatarGlow(
                  endRadius: 60,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 2),
                  startDelay: Duration(seconds: 1),
                  child: Material(
                      elevation: 8.0,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: FlutterLogo(
                          size: 30.0,
                        ),
                        radius: 30.0,
                      )),
                ),
                Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                            controller: TextEditingController()
                              ..text = userName != null ? userName : "",
                            onChanged: (String value) {
                              userName = value;
                            },
                            onSaved: (String value) {
                              userName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter user name here(optional)',
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
                                    color: Theme.of(context).buttonColor,
                                    width: 1),
                              ),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            controller: TextEditingController()
                              ..text = email != null ? email : "",
                            onChanged: (String value) {
                              email = value;
                            },
                            onSaved: (String value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter email here',
                              prefixIcon: Icon(Icons.email),
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
                                    color: Theme.of(context).buttonColor,
                                    width: 1),
                              ),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                            autocorrect: true,
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
                              hintText: 'Enter password here ',
                              prefixIcon: Icon(Icons.lock),
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
                                    color: Theme.of(context).buttonColor,
                                    width: 1),
                              ),
                            ),
                          )),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 70.0,
                        buttonColor: Theme.of(context).buttonColor,
                        child: RaisedButton(
                          onPressed: () {
                            SnackBar(
                              content: Text('Creating your account'));
                              submit();
                          },
                          child: Text('CONTINUE',
                              style: Theme.of(context).textTheme.button),
                        ),
                      )
                    ])),
                SizedBox(
                  height: 50.0,
                ),
                Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            this.viewModel.signInWithGoogle().then((userId) {
                              if (userId != null && userId) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return MyLeaderboardView();
                                }));
                              }
                            });
                          },
                          color: Colors.white,
                          textColor: Theme.of(context).buttonColor,
                          child: Icon(
                            FontAwesomeIcons.google,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                      ]),
                ]),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 70.0,
                    buttonColor: Theme.of(context).buttonColor,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInView(),
                          ),
                        );
                      },
                      child: Text('LOGIN',
                          style: Theme.of(context).textTheme.button),
                    )),
              ],
            ),
          ));
    });
    return MasterWidget(showDrawer: false, body: body, title: "");
  }
}
