part of additional_information_view;

class _AdditionalInformationMobile extends StatelessWidget {
  final AdditionalInformationViewModel viewModel;

  _AdditionalInformationMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(5.0),
                  child: Row(children: <Widget>[
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
                    Text("Personal Information",
                        style: Theme.of(context).textTheme.headline),
                  ])),
              Container(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Date Of Birth',
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
                      hintText: 'Gender',
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationSetupView(),
                      ),
                    );
                  },
                  child: Text('CONTINUE',
                      style: Theme.of(context).textTheme.button),
                ),
              )
            ]))));
  }
}
