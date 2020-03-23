part of my_leaderboard_view;

class _MyLeaderboardDesktop extends StatelessWidget {
  final MyLeaderboardViewModel viewModel;

  _MyLeaderboardDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('MyLeaderboardDesktop')),
    );
  }
}