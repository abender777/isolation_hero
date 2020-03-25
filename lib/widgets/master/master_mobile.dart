part of master_widget;

class _MasterMobile extends StatelessWidget {
  final bool showDrawer;
  final Widget body;
  final String title;

  const _MasterMobile({Key key, this.showDrawer, this.body, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(title != null ? title : "",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
                fontFamily: 'Monte')),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: body,
      drawer: Drawer(),
    );
  }
}
