class Leaderboard {
  int id;
  int points;
  int user;
  int level;
  String userEmail;
  String username;

  Leaderboard(
      {this.id,
      this.points,
      this.user,
      this.level,
      this.userEmail,
      this.username});

  Leaderboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    user = json['user'];
    level = json['level'];
    userEmail = json['user_email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    data['user'] = this.user;
    data['level'] = this.level;
    data['user_email'] = this.userEmail;
    data['username'] = this.username;
    return data;
  }
}
