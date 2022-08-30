import 'dart:ffi';

class NovelModel {
  int? id;
  String? title;
  String? image;
  int? likes;
  int? comments;
  String? description;
  int? status;
  int? featureProduct;
  int? flashProduct;
  CreatedBy? createdBy;
  String? createdAt;
  String? updatedAt;
  List<Chapters>? chapters;
  List<Attributes>? attributes;

  NovelModel(
      {this.id,
      this.title,
      this.image,
      this.likes,
      this.comments,
      this.description,
      this.status,
      this.featureProduct,
      this.flashProduct,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.chapters,
      this.attributes});

  NovelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    likes = json['likes'];
    comments = json['comments'];
    description = json['description'];
    status = json['status'];
    featureProduct = json['feature_product'];
    flashProduct = json['flash_product'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['description'] = this.description;
    data['status'] = this.status;
    data['feature_product'] = this.featureProduct;
    data['flash_product'] = this.flashProduct;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  CreatedBy(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Chapters {
  int? id;
  int? number;
  String? name;
  String? description;
  int? status;
  int? productId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Chapters(
      {this.id,
      this.number,
      this.name,
      this.description,
      this.status,
      this.productId,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Chapters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    productId = json['product_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['product_id'] = this.productId;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  int? status;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Attributes(
      {this.id,
      this.name,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
    });

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

