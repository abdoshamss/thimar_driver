class OrdersData {
  late final List<OrderModel> list;
  late final Links links;
  late final Meta meta;
  late final String status, message;

  OrdersData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => OrderModel.fromJson(e))
        .toList();
    links = Links.fromJson(json['links']??{});
    meta = Meta.fromJson(json['meta']??{});
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
}

class OrderModel {
  late final int id;
  late final String status, date, time, clientImage, clientName, payType, phone;

  late final double? totalPrice, orderPrice, deliveryPrice;

  late final Address address;

  late final List<Images> images;

  String get stringTotalPrice => totalPrice.toString().replaceAll(".0", "");

  String get stringOrderPrice => orderPrice.toString().replaceAll(".0", "");

  String get stringDeliveryPrice =>
      deliveryPrice.toString().replaceAll(".0", "");

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    status = json['status'] ?? "";
    date = json['date'] ?? "";
    time = json['time'] ?? "";
    orderPrice = double.tryParse(json['order_price'].toString()) ?? 0;
    deliveryPrice = double.tryParse(json['delivery_price'].toString()) ?? 0;
    totalPrice = double.tryParse(json['total_price'].toString()) ?? 0;

    address = Address.fromJson(json['address']??{});

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

class Links {
  late final String first, last, next;

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'] ?? "";
    last = json['last'] ?? "";

    next = json['next'] ?? "";
  }
}

class Meta {
  late final int currentPage, from, lastPage, perPage, to, total;

  late final List<Links> links;
  late final String path;

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    links =
        List.from(json['links'] ?? []).map((e) => Links.fromJson(e)).toList();
    path = json['path'] ?? "";
    perPage = json['per_page'] ?? 0;
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
  }
}
