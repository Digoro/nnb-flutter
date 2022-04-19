import 'package:nnb_flutter/models/payment.dart';
import 'package:nnb_flutter/models/user.dart';

class Product {
  final int id;
  final String title;
  final int price;
  final int? discountPrice;
  final String point;
  final String recommend;
  final String? description;
  final String? address;
  final String? detailAddress;
  final String? howToCome;
  final int runningDays;
  final int runningHours;
  final int runningMinutes;
  final int reservationHours;
  final double? lat;
  final double? lon;
  final User? host;
  final String notice;
  final String checkList;
  final String includeList;
  final String excludeList;
  final int refundPolicy100;
  final int refundPolicy0;
  final int sortOrder;
  final String status;
  final bool isBusiness;
  final bool isOffline;
  final String color;
  // final String hashtags;
  // final String categories;
  final int likes;
  // final bool isSetLike;
  // final String options;
  final String createdAt;
  final String updatedAt;
  final List<RepresentationPhoto> representationPhotos;
  // final String productReviews;
  // final String gift;
  // final String productConfirms;
  // final String onlineMethod;
  final List<Order> orders;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.discountPrice,
    required this.point,
    required this.recommend,
    this.description,
    required this.address,
    required this.detailAddress,
    this.howToCome,
    required this.runningDays,
    required this.runningHours,
    required this.runningMinutes,
    required this.reservationHours,
    required this.lat,
    required this.lon,
    this.host,
    required this.notice,
    required this.checkList,
    required this.includeList,
    required this.excludeList,
    required this.refundPolicy100,
    required this.refundPolicy0,
    required this.sortOrder,
    required this.status,
    required this.isBusiness,
    required this.isOffline,
    required this.color,
    // required this.hashtags,
    // required this.categories,
    required this.likes,
    // required this.isSetLike,
    // required this.options,
    required this.createdAt,
    required this.updatedAt,
    required this.representationPhotos,
    // required this.productReviews,
    // required this.gift,
    // required this.productConfirms,
    // required this.onlineMethod,
    required this.orders,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      discountPrice: json['discountPrice'],
      point: json['point'],
      recommend: json['recommend'],
      description: json['description'],
      address: json['address'],
      detailAddress: json['detailAddress'],
      howToCome: json['howToCome'],
      runningDays: json['runningDays'],
      runningHours: json['runningHours'],
      runningMinutes: json['runningMinutes'],
      reservationHours: json['reservationHours'],
      lat: json['lat'] == 0 ? 0.0 : json['lat'],
      lon: json['lon'] == 0 ? 0.0 : json['lon'],
      host: json['host'] == null ? null : User.fromJson(json['host']),
      notice: json['notice'],
      checkList: json['checkList'],
      includeList: json['includeList'],
      excludeList: json['excludeList'],
      refundPolicy100: json['refundPolicy100'],
      refundPolicy0: json['refundPolicy0'],
      sortOrder: json['sortOrder'],
      status: json['status'],
      isBusiness: json['isBusiness'],
      isOffline: json['isOffline'],
      color: json['color'],
      // hashtags: json['hashtags'],
      // categories: json['categories'],
      likes: json['likes'],
      // isSetLike: json['isSetLike'],
      // options: json['options'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      representationPhotos: List<RepresentationPhoto>.from(json["representationPhotos"].map((e) => RepresentationPhoto.fromJson(e))),
      // productReviews: json['productReviews'],
      // gift: json['gift'],
      // productConfirms: json['productConfirms'],
      // onlineMethod: json['onlineMethod'],
      orders: List<Order>.from(json["orders"].map((e) => Order.fromJson(e))),
    );
  }
}

class RepresentationPhoto {
  final int id;
  final String photo;
  final int sortOrder;

  RepresentationPhoto({
    required this.id,
    required this.photo,
    required this.sortOrder,
  });

  factory RepresentationPhoto.fromJson(Map<String, dynamic> json) {
    return RepresentationPhoto(
      id: json['id'],
      photo: json['photo'],
      sortOrder: json['sortOrder'],
    );
  }
}
