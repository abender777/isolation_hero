part of leaderboard_view;

class _LeaderboardDesktop extends StatelessWidget {
  final LeaderboardViewModel viewModel;

  _LeaderboardDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('LeaderboardDesktop')),
    );
  }
}