part of 'bloc.dart';

class CitiesData {
  late final List<CityModel> data;
  late final String status, message;

  CitiesData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'] ?? []).map((e) => CityModel.fromJson(e)).toList();
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class CityModel {
  late final String id, name;

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }
}
