class Leaderboard {
  String name;
  String pointsEarned;
  String rank;

  Leaderboard({this.name, this.pointsEarned, this.rank});

  Leaderboard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pointsEarned = json['points_earned'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['points_earned'] = this.pointsEarned;
    data['rank'] = this.rank;
    return data;
  }
}
