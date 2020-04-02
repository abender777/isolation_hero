class BackInTime {
  int timeInMinutes;
  String name;

  BackInTime({this.timeInMinutes, this.name});

  BackInTime.fromJson(Map<String, dynamic> json) {
    timeInMinutes = json['time_in_minutes'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_in_minutes'] = this.timeInMinutes;
    data['name'] = this.name;
    return data;
  }
}
