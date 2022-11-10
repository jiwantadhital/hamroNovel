class AttributeModel {
  int? id;
  String? name;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  List<Novel>? novel;

  AttributeModel(
      {this.id,
      this.name,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.novel});

  AttributeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['novel'] != null) {
      novel = <Novel>[];
      json['novel'].forEach((v) {
        novel!.add(new Novel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.novel != null) {
      data['novel'] = this.novel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Novel {
  int? id;
  String? title;
  String? image;
  int? likes;
  String? description;
  int? status;
  int? featureProduct;
  int? flashProduct;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Novel(
      {this.id,
      this.title,
      this.image,
      this.likes,
      this.description,
      this.status,
      this.featureProduct,
      this.flashProduct,
      this.createdBy,
      this.createdAt,
      this.updatedAt,});

  Novel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    likes = json['likes'];
    description = json['description'];
    status = json['status'];
    featureProduct = json['feature_product'];
    flashProduct = json['flash_product'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['likes'] = this.likes;
    data['description'] = this.description;
    data['status'] = this.status;
    data['feature_product'] = this.featureProduct;
    data['flash_product'] = this.flashProduct;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
