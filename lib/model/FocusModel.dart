class FocusList {
  List<FocusModel>? result;

  FocusList({this.result});

  FocusList.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FocusModel>[];
      json['result'].forEach((v) {
        result!.add(FocusModel.fromJson(v));
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

class FocusModel {
  String? id;
  String? title;
  String? status;
  String? url;
  String? pic;

  FocusModel({this.id, this.title, this.status, this.url, this.pic});

  FocusModel.fromJson(Map<String, dynamic> json) {
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
