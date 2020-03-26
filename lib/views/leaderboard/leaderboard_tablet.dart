part of leaderboard_view;

class _LeaderboardTablet extends StatelessWidget {
  final LeaderboardViewModel viewModel;

  _LeaderboardTablet(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LeaderboardTablet')),
    );
  }
}