part of sign_in_view;

class _SignInMobile extends StatefulWidget {
  final SignInViewModel viewModel;

  _SignInMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _SignInMobileState();
  }
}

class _SignInMobileState extends State<_SignInMobile> {
  Widget body;

  @override
  Widget build(BuildContext context) {
    setState(() {
    body = Scaffold(
        body: Stack(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(5.0),
                  child: Row(children: <Widget>[
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
                    Text("Sign In",
                        style: Theme.of(context).textTheme.headline),
                  ])),
                Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Enter User name/email',
                        prefixIcon: Icon(Icons.person),
                        hintStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: 'Monte'),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.email),
                        hintStyle: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontFamily: 'Monte'),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                    ))
              ])),
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
                      onPressed: () {},
                      child: Text('LOGIN',
                          style: Theme.of(context).textTheme.button),
                    )),
              )
            ]));                
    });
  return MasterWidget(body: body);
  }
}
