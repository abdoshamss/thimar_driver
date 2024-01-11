part of 'bloc.dart';

class UserData {
  late final UserModel list;
  late final String status, message;

  UserData.fromJson(Map<String, dynamic> json) {
    list = UserModel.fromJson(json['data'] ?? []);
    status = json['status'] ?? "";
    message = json['message']??"" ;
  }
}

class UserModel {
  late final int id, isBan, userCartCount, unreadNotifications;
  late final String fullname,
      phone,
      email,
      image,
      identityNumber,
      userType,
      token;

  late final bool isActive;

  late final City city;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    fullname = json['fullname'] ?? "";
    phone = json['phone'] ?? "";
    email = json['email'] ?? "";
    image = json['image'] ?? "";
    isBan = json['is_ban'] ?? 0;
    isActive = json['is_active'] ?? false;
    unreadNotifications = json['unread_notifications'] ?? "";
    userType = json['user_type']??"";
    token = json['token']??"";

    city = City.fromJson(json['city']??{});
    identityNumber = json['identity_number']??"";
    userCartCount = json['user_cart_count']??0;
  }
}

class City {
  late final String id, name;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
  }
}
