class ProductModel {
  List<ProductItem>? result;

  ProductModel({this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProductItem>[];
      json['result'].forEach((v) {
        result!.add(ProductItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItem {
  String? id;
  String? title;
  String? cid;
  int? price;
  int? oldPrice;
  String? pic;
  String? sPic;

  ProductItem(
      {this.id,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['pic'] = pic;
    data['s_pic'] = sPic;
    return data;
  }
}
