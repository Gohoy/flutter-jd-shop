class FocusModel {
  List<FocusItem>? result;

  FocusModel({this.result});

  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FocusItem>[];
      json['result'].forEach((v) {
        result!.add(FocusItem.fromJson(v));
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

class FocusItem {
  String? id;
  String? title;
  String? status;
  String? url;
  String? pic;

  FocusItem({this.id, this.title, this.status, this.url, this.pic});

  FocusItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    url = json['url'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['url'] = url;
    data['pic'] = pic;
    return data;
  }
}
