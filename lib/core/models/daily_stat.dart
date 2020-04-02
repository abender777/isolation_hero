
import 'package:intl/intl.dart';

class UserDailyStat {
  int id;
  int day;
  int month;
  String dayName;
  String monthName;
  int year;
  double percentageScore;
  int status;
  String createdAt;
  String updatedAt;
  int user;

  UserDailyStat(
      {this.id,
      this.day,
      this.month,
      this.year,
      this.percentageScore,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  UserDailyStat.fromJson(Map<String, dynamic> json) {
    var dateTime = new DateTime.utc(json['year'], json['month'], json['day']);
    id = json['id'];
    dayName = new DateFormat('EEEE').format(dateTime);
    monthName = new DateFormat('LLL').format(dateTime);
    month = json['month'];
    year = json['year'];
    percentageScore = json['percentage_score'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['month'] = this.month;
    data['year'] = this.year;
    data['percentage_score'] = this.percentageScore;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}
