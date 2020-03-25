part of drawer_widget;

class _DrawerMobile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DrawerState();
  }
}

class _DrawerState extends State<_DrawerMobile> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.only(top: 30),
        children: <Widget>[
          menuItem(1, "Best Offers", Icons.access_alarm, null),
          menuItem(2, "Cross Fit", Icons.access_alarm, null),
          menuItem(3, "Programs", Icons.access_alarm, null),
        ],
      ),
    );
  }

  ListTile menuItem(
      int menuBarNumber, String name, Object icon, Object action) {
    return ListTile(
        title: Text(
          name,
          style: Theme.of(context).textTheme.caption,
        ),
        onTap: () {
          setState(() {
            _selectedIndex = menuBarNumber;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => action));
        },
        trailing: Icon(icon, color: Colors.grey, size: 30.0),
        selected: _selectedIndex == menuBarNumber);
  }
}
