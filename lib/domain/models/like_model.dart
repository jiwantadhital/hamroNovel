class LikeModel {
  int? id;
  String? liked;
  int? productId;
  String? createdAt;
  String? updatedAt;

  LikeModel(
      {this.id,
      this.liked,
      this.productId,
      this.createdAt,
      this.updatedAt,});

  LikeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liked = json['liked'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['liked'] = this.liked;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
