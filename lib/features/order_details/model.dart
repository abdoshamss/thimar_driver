part of 'bloc.dart';

class OrderDetailsData {
  
  late final String status,message;

  late final OrderDetailsModel order;

  OrderDetailsData.fromJson(Map<String, dynamic> json){
    status = json['status']??"";
    message = json['message']??"";
    order = OrderDetailsModel.fromJson(json['data']??{});
  }

  
}

class OrderDetailsModel {
  late final int id;
  late final String status, date, time, clientImage, clientName, payType, phone;

  late final double? totalPrice, orderPrice, deliveryPrice;

  late final Address address;

  late final List<Images> images;

  String get stringTotalPrice => totalPrice.toString().replaceAll(".0", "");

  String get stringOrderPrice => orderPrice.toString().replaceAll(".0", "");

  String get stringDeliveryPrice =>
      deliveryPrice.toString().replaceAll(".0", "");

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    status = json['status'] ?? "";
    date = json['date'] ?? "";
    time = json['time'] ?? "";
    orderPrice = double.tryParse(json['order_price'].toString()) ?? 0;
    deliveryPrice = double.tryParse(json['delivery_price'].toString()) ?? 0;
    totalPrice = double.tryParse(json['total_price'].toString()) ?? 0;

    address = Address.fromJson(json['address'] ?? {});

    payType = json['pay_type'] ?? "";
    phone = json['phone'] ?? "";
    clientName = json['client_name'] ?? "";
    clientImage = json['client_image'] ?? "";

    images =
        List.from(json['images'] ?? []).map((e) => Images.fromJson(e)).toList();
  }
}

class Address {
  late final int id, userId;
  late final String type, location, description, phone, createdAt, updatedAt;
  late final double lat, lng;

  late final bool isDefault;

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? "";
    lat = double.tryParse(json['lat'].toString()) ?? 0;
    lng = double.tryParse(json['lng'].toString()) ?? 0;
    location = json['location'] ?? "";
    description = json['description'] ?? "";
    userId = json['user_id'] ?? 0;
    isDefault = json['is_default'] == 1;
    phone = json['phone'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }
}

class Images {
  late final String name, url;

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    url = json['url'] ?? "";
  }
}