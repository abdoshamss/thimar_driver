part of 'bloc.dart';
class NotificationData {

  late final NotificationModel data;
  late final Links links;
  late final Meta meta;

  late final String status,message;

  NotificationData.fromJson(Map<String, dynamic> json){
    data = NotificationModel.fromJson(json['data']??{});
    links = Links.fromJson(json['links']??{});
    meta = Meta.fromJson(json['meta']??{});
    status = json['status']??"";
    message = json['message']??"";
  }


}

class NotificationModel {

  late final int unreadnotificationsCount;
  late final List<Notifications> list;

  NotificationModel.fromJson(Map<String, dynamic> json){
    unreadnotificationsCount = json['unreadnotifications_count']??0;
    list = List.from(json['notifications']??[]).map((e)=>Notifications.fromJson(e)).toList();
  }


}

class Notifications {

  late final String id,title,body,notifyType,createdAt,readAt,image;
  late final Order order;



  Notifications.fromJson(Map<String, dynamic> json){
    id = json['id']??"";
    title = json['title']??"";
    body = json['body']??"";
    notifyType = json['notify_type']??"";
    order = Order.fromJson(json['order']??{});

    createdAt = json['created_at']??"";
    readAt = json['read_at']??"";
    image = json['image']??"";
  }


}

class Order {

  late final int orderId,clientId,driverId;


  late final String orderStatus;

  Order.fromJson(Map<String, dynamic> json){
    orderId = json['order_id']??0;
    clientId = json['client_id']??0;
    driverId = json['driver_id']??0;

    orderStatus = json['order_status']??"";
  }


}

class Links {

  late final String first,last;



  Links.fromJson(Map<String, dynamic> json){
    first = json['first']??"";
    last = json['last']??"";

  }


}

class Meta {

  late final int currentPage,from,lastPage,perPage,to,total;

  late final List<Links> links;
  late final String path;


  Meta.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page']??0;
    from = json['from']??0;
    lastPage = json['last_page']??0;
    links = List.from(json['links']??[]).map((e)=>Links.fromJson(e)).toList();
    path = json['path']??"";
    perPage = json['per_page']??0;
    to = json['to']??0;
    total = json['total']??0;
  }


}