import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/daily_stat.dart';
import 'package:isolationhero/core/models/leaderboard_stat.dart';

class MyLeaderboardViewModel extends BaseViewModel {
  MyLeaderboardViewModel();

  List<LearderbordStat> _learderbordStats;
  List<LearderbordDailyStat> _learderbordDailyStats;

  List<LearderbordStat> get learderbordStats => this._learderbordStats;
  List<LearderbordDailyStat> get learderbordDailyStats =>
      this._learderbordDailyStats;

  set setLearderbordStats(List<LearderbordStat> learderbordStats) {
    this._learderbordStats = learderbordStats;
    notifyListeners();
  }

  set setLearderbordDailyStats(
      List<LearderbordDailyStat> learderbordDailyStats) {
    this._learderbordDailyStats = learderbordDailyStats;
    notifyListeners();
  }

  void getLearderbordStats() async {
    List<LearderbordStat> learderbordStats = new List<LearderbordStat>();
    learderbordStats.add(new LearderbordStat(name: "points", count: "1433"));
    learderbordStats.add(new LearderbordStat(name: "level", count: "6"));
    setLearderbordStats = learderbordStats;
  }

  void getLearderbordDailyStats() async {
    List<LearderbordDailyStat> learderbordDailyStats =
        new List<LearderbordDailyStat>();
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "27",
        day: "Fri",
        month: "March",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "28",
        day: "Sat",
        month: "March",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "29",
        day: "Sun",
        month: "March",
        percentage: "90",
        status: "OK"));
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "30",
        day: "Mon",
        month: "March",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "31",
        day: "Tue",
        month: "March",
        percentage: "98",
        status: "OK"));
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "1",
        day: "Wed",
        month: "April",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new LearderbordDailyStat(
        date: "2", day: "Thu", month: "April", percentage: "80", status: "OK"));
    setLearderbordDailyStats = learderbordDailyStats;
  }
}
