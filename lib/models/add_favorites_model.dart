class AddFavoritesModel {
  bool? status;
  String? message;

  AddFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
