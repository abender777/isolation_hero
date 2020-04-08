class Instruction {
  int id;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  Instruction(
      {this.id,
      this.imageUrl,
      this.description,
      this.createdAt,
      this.updatedAt});

  Instruction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
