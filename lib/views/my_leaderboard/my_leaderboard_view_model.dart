import 'package:isolationhero/core/base/base_view_model.dart';
import 'package:isolationhero/core/models/daily_stat.dart';
import 'package:isolationhero/core/models/user_stat.dart';

class MyLeaderboardViewModel extends BaseViewModel {
  MyLeaderboardViewModel();

  List<UserStat> _userStats;
  List<UserDailyStat> _userDailyStats;

  List<UserStat> get learderbordStats => this._userStats;
  List<UserDailyStat> get learderbordDailyStats => this._userDailyStats;

  set setLearderbordStats(List<UserStat> userStats) {
    this._userStats = userStats;
    notifyListeners();
  }

  set setLearderbordDailyStats(List<UserDailyStat> userDailyStats) {
    this._userDailyStats = userDailyStats;
    notifyListeners();
  }

  void getLearderbordStats() async {
    List<UserStat> learderbordStats = new List<UserStat>();
    learderbordStats.add(new UserStat(name: "points", count: "1433"));
    learderbordStats.add(new UserStat(name: "level", count: "6"));
    setLearderbordStats = learderbordStats;
  }

  void getLearderbordDailyStats() async {
    List<UserDailyStat> learderbordDailyStats = new List<UserDailyStat>();
    learderbordDailyStats.add(new UserDailyStat(
        date: "27",
        day: "Fri",
        month: "March",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new UserDailyStat(
        date: "28",
        day: "Sat",
        month: "March",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new UserDailyStat(
        date: "29",
        day: "Sun",
        month: "March",
        percentage: "90",
        status: "OK"));
    learderbordDailyStats.add(new UserDailyStat(
        date: "30",
        day: "Mon",
        month: "March",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new UserDailyStat(
        date: "31",
        day: "Tue",
        month: "March",
        percentage: "98",
        status: "OK"));
    learderbordDailyStats.add(new UserDailyStat(
        date: "1",
        day: "Wed",
        month: "April",
        percentage: "100",
        status: "OK"));
    learderbordDailyStats.add(new UserDailyStat(
        date: "2", day: "Thu", month: "April", percentage: "80", status: "OK"));
    setLearderbordDailyStats = learderbordDailyStats;
  }
}
