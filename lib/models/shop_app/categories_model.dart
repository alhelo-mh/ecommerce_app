import 'package:flutter/cupertino.dart';

class CategoriesModle {
  late bool status;
  late CategoriesDataModle data;

  CategoriesModle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModle.fromJson(json['data']);
  }
}

class CategoriesDataModle {
  late int current_page;

  List<DataModel> data = [];

  CategoriesDataModle.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
