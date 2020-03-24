class LearderbordDailyStat {
  String day;
  String date;
  String month;
  String percentage;
  String status;

  LearderbordDailyStat(
      {this.day, this.date, this.month, this.percentage, this.status});

  LearderbordDailyStat.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    date = json['date'];
    month = json['month'];
    percentage = json['percentage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['month'] = this.month;
    data['percentage'] = this.percentage;
    data['status'] = this.status;
    return data;
  }
}
