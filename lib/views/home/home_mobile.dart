part of home_view;

class _HomeMobile extends StatefulWidget {
  final HomeViewModel viewModel;

  const _HomeMobile({Key key, this.viewModel}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomeMobile>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
