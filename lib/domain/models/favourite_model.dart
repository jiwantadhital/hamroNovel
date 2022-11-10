class FavouriteModel {
  int? id;
  String? user;
  int? productId;
  String? createdAt;
  String? updatedAt;

  FavouriteModel(
      {this.id,
      this.user,
      this.productId,
      this.createdAt,
      this.updatedAt,
    });

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}