part of sign_up_view;

class _SignUpMobile extends StatefulWidget {
  final SignUpViewModel viewModel;

  _SignUpMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _SignUpMobileState();
  }
}

class _SignUpMobileState extends State<_SignUpMobile> {
  Widget body;

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
                Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        autocorrect: true,
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
                                color: Theme.of(context).buttonColor, width: 1),
                          ),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        autocorrect: true,
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
                                color: Theme.of(context).buttonColor, width: 1),
                          ),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        autocorrect: true,
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
                                color: Theme.of(context).buttonColor, width: 1),
                          ),
                        ),
                      )),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 70.0,
                    buttonColor: Theme.of(context).buttonColor,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdditionalInformationView(),
                          ),
                        );
                      },
                      child: Text('CONTINUE',
                          style: Theme.of(context).textTheme.button),
                    ),
                  )
                ]),
                SizedBox(
                  height: 50.0,
                ),
                Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Theme.of(context).buttonColor,
                          child: Icon(
                            FontAwesomeIcons.google,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Theme.of(context).buttonColor,
                          child: Icon(
                            FontAwesomeIcons.facebookF,
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
