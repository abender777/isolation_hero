part of my_leaderboard_view;

class _MyLeaderboardMobile extends StatelessWidget {
  final MyLeaderboardViewModel viewModel;

  _MyLeaderboardMobile(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MyLeaderboardMobile')),
    );
  }
}