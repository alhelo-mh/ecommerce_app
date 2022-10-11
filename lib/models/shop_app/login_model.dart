// "status": true,
// "message": "تم تسجيل الدخول بنجاح",
// "data": {
//     "id": 19742,
//     "name": "Mohmed maher",
//     "email": "mohmd.maher20@gmail.com",
//     "phone": "0594351033",
//     "image": "https://student.valuxapps.com/storage/uploads/users/hoSD2i3j8H_1663663577.jpeg",
//     "points": 0,
//     "credit": 0,
//     "token": "kOHrL8ZlErYdQ3Hnqo2E3OVJ9LlwB2oGF7JLDpbuB5dWGgu420msRsiAOj5wiKz9gDcm4u"

class loginModel {
  bool? status;
  String? message;
  UserData? data;

  loginModel.formJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = UserData.formJson(json['data']);
    } else {}
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // UserData({
  //   required this.id,
  //   required this.name,
  //   required this.email,
  //   required this.phone,
  //   required this.image,
  //   required this.points,
  //   required this.credit,
  //   required this.token,
  // });

  UserData.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
