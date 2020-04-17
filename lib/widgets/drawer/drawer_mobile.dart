part of drawer_widget;

class _DrawerMobile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawerState();
  }
}

class _DrawerState extends State<_DrawerMobile> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color.fromRGBO(44, 74, 104, 1),
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.only(top: 30),
        children: <Widget>[
          new Container(
              child: new DrawerHeader(
                child: AvatarGlow(
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
                        child: Image(image: ExactAssetImage("assets/ih.png")),
                        radius: 30.0,
                      )),
                ),
              ),
              color: Color.fromRGBO(44, 74, 104, 1)),
          new Container(
              color: Color.fromRGBO(44, 74, 104, 1),
              child: new Column(children: <Widget>[
                menuItem(1, "My Stats", FontAwesomeIcons.sortNumericUpAlt,
                    MyLeaderboardView()),
                Divider(color: Colors.white),
                menuItem(2, "Leaderboard", FontAwesomeIcons.trophy,
                    LeaderboardView()),
                Divider(color: Colors.white),
                menuItem(
                    3, "Going Out", FontAwesomeIcons.running, GoingOutView()),
                Divider(color: Colors.white),
                menuItem(4, "Earn More Points", FontAwesomeIcons.plusCircle,
                    EarnMorePointsView()),
                Divider(color: Colors.white),
                // menuItem(
                //     5, "My Profile", FontAwesomeIcons.user, UserProfileView()),
                // Divider(color: Colors.white),
                menuItemForLogout(
                    6, "Logout", FontAwesomeIcons.signOutAlt, SignInView())
              ]))
        ],
      ),
    ));
  }

  ListTile menuItem(
      int menuBarNumber, String name, Object icon, Object action) {
    return ListTile(
        title: Text(
          name,
          style: TextStyle(
              fontFamily: 'Monte',
              fontSize: 16,
              color: Color.fromRGBO(13, 169, 196, 1)),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = menuBarNumber;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => action));
        },
        trailing: Icon(icon, color: Colors.amber, size: 20.0),
        selected: _selectedIndex == menuBarNumber);
  }

  ListTile menuItemForLogout(
      int menuBarNumber, String name, Object icon, Object action) {
    return ListTile(
        title: Text(
          name,
          style: TextStyle(
              fontFamily: 'Monte',
              fontSize: 16,
              color: Color.fromRGBO(13, 169, 196, 1)),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = menuBarNumber;
          });
          logout();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => action));
        },
        trailing: Icon(icon, color: Colors.amber, size: 20.0),
        selected: _selectedIndex == menuBarNumber);
  }

  void logout() async {
    try {
        SecuredStorage securedStorage = SecuredStorage.instance;
        await securedStorage.deleteValue("user_id");
        await securedStorage.deleteValue("token");
      _googleSignIn.signOut();
    } on Exception {
      final response =
          await http.get(API_BASE_URL + '/users/rest-auth/logout/');

      if (response.statusCode == 200) {
        print("Logout done");
      }
    }
  }
}
