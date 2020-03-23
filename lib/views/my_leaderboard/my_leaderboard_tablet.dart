part of my_leaderboard_view;

class _MyLeaderboardTablet extends StatelessWidget {
  final MyLeaderboardViewModel viewModel;

  _MyLeaderboardTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MyLeaderboardTablet')),
    );
  }
}