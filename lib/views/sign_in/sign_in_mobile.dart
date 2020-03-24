part of sign_in_view;

class _SignInMobile extends StatelessWidget {
  final SignInViewModel viewModel;

  _SignInMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(padding: EdgeInsets.all(5.0), child: Text("Sign In")),
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
                  )),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 70.0,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: () {},
                  child:
                      Text('LOGIN', style: Theme.of(context).textTheme.button),
                ),
              )
            ]))));
  }
}
