part of going_out_view;

class _GoingOutMobile extends StatefulWidget {
  final GoingOutViewModel viewModel;

  _GoingOutMobile(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    return _GoingOutMobileState();
  }
}

class _GoingOutMobileState extends State<_GoingOutMobile> {
  Widget body;

  @override
  Widget build(BuildContext context) {
    setState(() {
      body = Stack(children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Reason for going out?',
                      prefixIcon: Icon(Icons.person),
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: 'Monte'),
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
                      hintText: 'Back In',
                      prefixIcon: Icon(Icons.email),
                      hintStyle: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontFamily: 'Monte'),
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
              ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 70.0,
                  buttonColor: Theme.of(context).buttonColor,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('SUBMIT',
                        style: Theme.of(context).textTheme.button),
                  ))
            ])),
      ]);
    });
    return MasterWidget(
        showDrawer: true,
        body: body,
        title: "EARN MORE POINTS",
        showAppBar: true);
  }
}
