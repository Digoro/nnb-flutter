import 'package:nnb_flutter/models/user.dart';

class Payment {
  final int id;
  final Order? order;
  final String? pgName;
  final String? pgOrderId;
  final String payAt;
  final int totalPrice;
  final String payMethod;
  final int payPrice;
  final int payCommissionPrice;
  final bool result;
  final String resultMessage;
  final String? cardName;
  final String? cardNum;
  final String? cardReceipt;
  final String? bankName;
  final String? bankNum;
  final String createdAt;
  final String updatedAt;
  final bool isRequestReview;
  final List<Review>? reviews;
  final PaymentCancel? paymentCancel;
  final List<Feed>? feed;
  final dynamic error;

  Payment({
    required this.id,
    this.order,
    this.pgName,
    this.pgOrderId,
    required this.payAt,
    required this.totalPrice,
    required this.payMethod,
    required this.payPrice,
    required this.payCommissionPrice,
    required this.result,
    required this.resultMessage,
    this.cardName,
    this.cardNum,
    this.cardReceipt,
    this.bankName,
    this.bankNum,
    required this.createdAt,
    required this.updatedAt,
    required this.isRequestReview,
    required this.reviews,
    this.paymentCancel,
    required this.feed,
    required this.error,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      order: json['order'] == null ? null : Order.fromJson(json['order']),
      pgName: json['pgName'],
      pgOrderId: json['pgOrderId'],
      payAt: json['payAt'],
      totalPrice: json['totalPrice'],
      payMethod: json['payMethod'],
      payPrice: json['payPrice'],
      payCommissionPrice: json['payCommissionPrice'],
      result: json['result'],
      resultMessage: json['resultMessage'],
      cardName: json['cardName'],
      cardNum: json['cardNum'],
      cardReceipt: json['cardReceipt'],
      bankName: json['bankName'],
      bankNum: json['bankNum'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isRequestReview: json['isRequestReview'],
      reviews: json['reviews'],
      paymentCancel: json['paymentCancel'] == null ? null : PaymentCancel.fromJson(json['paymentCancel']),
      feed: json['feed'],
      error: json['error'],
    );
  }
}

class Order {
  final int id;
  final User? user;
  final NonMember? nonMember;
  final Coupon? coupon;
  final Gift? gift;
  final int? point;
  final String orderAt;
  final String? description;
  final Payment payment;

  Order({
    required this.id,
    this.user,
    this.nonMember,
    this.coupon,
    this.gift,
    this.point,
    required this.orderAt,
    this.description,
    required this.payment,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
      nonMember: json['nonMember'] == null ? null : NonMember.fromJson(json['nonMember']),
      coupon: json['coupon'] == null ? null : Coupon.fromJson(json['coupon']),
      gift: json['gift'] == null ? null : Gift.fromJson(json['gift']),
      point: json['point'],
      orderAt: json['orderAt'],
      description: json['description'],
      payment: Payment.fromJson(json['payment']),
    );
  }
}

class OrderItem {
  OrderItem();

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem();
  }
}

class Review {
  Review();

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review();
  }
}

class PaymentCancel {
  PaymentCancel();

  factory PaymentCancel.fromJson(Map<String, dynamic> json) {
    return PaymentCancel();
  }
}

class Feed {
  Feed();

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed();
  }
}
