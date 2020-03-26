import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/leaderboard.dart';

class LeaderboardViewModel extends BaseViewModel {
  LeaderboardViewModel();

  List<Leaderboard> _leaderboards;

  List<Leaderboard> get leaderboards => this._leaderboards;

  set setLearderbords(List<Leaderboard> leaderboards) {
    this._leaderboards = leaderboards;
    notifyListeners();
  }

  void getLearderbords() async {
    List<Leaderboard> learderbords = new List<Leaderboard>();
    learderbords
        .add(new Leaderboard(name: "Mahesh", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Natha", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Priya", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Vaishak", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Akshay", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Dinesh", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Priya", pointsEarned: "1433", rank: "1"));
    learderbords
        .add(new Leaderboard(name: "Vaishak", pointsEarned: "1433", rank: "1"));

    setLearderbords = learderbords;
  }
}
