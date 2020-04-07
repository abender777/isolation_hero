class BonusPointLink {
  int id;
  String link;
  String name;
  String description;
  String validTill;
  double points;
  String createdAt;
  String updatedAt;

  BonusPointLink(
      {this.id,
      this.link,
      this.name,
      this.description,
      this.validTill,
      this.points,
      this.createdAt,
      this.updatedAt});

  BonusPointLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    description = json['description'];
    validTill = json['valid_till'];
    points = json['points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['description'] = this.description;
    data['valid_till'] = this.validTill;
    data['points'] = this.points;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
