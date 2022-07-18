class UserTempModel {
  String? userName;
  String? phone;

  UserTempModel(this.userName, this.phone);
}

class UserFireModel {
  String? name;
  String? phone;
  int? line;

  UserFireModel(this.name, this.phone, this.line);

  UserFireModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    line = json['line'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['line'] = this.line;
    return data;
  }
}
