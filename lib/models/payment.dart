import 'package:nnb_flutter/models/product.dart';
import 'package:nnb_flutter/models/user.dart';

class Payment {
  final int id;
  final Order? order;
  final String? pgName;
  final String? pgOrderId;
  final DateTime payAt;
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isRequestReview;
  // final List<Review>? reviews;
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
    // required this.reviews,
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
      payAt: DateTime.parse(json['payAt']),
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isRequestReview: json['isRequestReview'],
      // reviews: json['reviews'],
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
  final DateTime orderAt;
  final String? description;
  final List<OrderItem>? orderItems;
  final Product? product;
  final Payment? payment;

  Order({
    required this.id,
    this.user,
    this.nonMember,
    this.coupon,
    this.gift,
    this.point,
    required this.orderAt,
    this.description,
    this.orderItems,
    this.product,
    this.payment,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
      nonMember: json['nonMember'] == null ? null : NonMember.fromJson(json['nonMember']),
      coupon: json['coupon'] == null ? null : Coupon.fromJson(json['coupon']),
      gift: json['gift'] == null ? null : Gift.fromJson(json['gift']),
      point: json['point'],
      orderAt: DateTime.parse(json['orderAt']),
      description: json['description'],
      orderItems: json['orderItems'] == null ? null : List<OrderItem>.from(json["orderItems"].map((e) => OrderItem.fromJson(e))),
      product: json['product'] == null ? null : Product.fromJson(json['product']),
      payment: json['payment'] == null ? null : Payment.fromJson(json['payment']),
    );
  }
}

class OrderItem {
  final int id;
  final Order? order;
  final ProductOption? productOption;
  final int count;

  OrderItem({
    required this.id,
    this.order,
    this.productOption,
    required this.count,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      order: json['order'] == null ? null : Order.fromJson(json['order']),
      productOption: json['productOption'] == null ? null : ProductOption.fromJson(json['productOption']),
      count: json['count'],
    );
  }
}

class Review {
  Review();

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review();
  }
}

class PaymentCancel {
  final int id;
  final String reason;
  final int refundPrice;
  final DateTime cancelAt;
  final bool refundCoupon;
  final bool refundPoint;

  PaymentCancel({
    required this.id,
    required this.reason,
    required this.refundPrice,
    required this.cancelAt,
    required this.refundCoupon,
    required this.refundPoint,
  });

  factory PaymentCancel.fromJson(Map<String, dynamic> json) {
    return PaymentCancel(
      id: json['id'],
      reason: json['reason'],
      refundPrice: json['refundPrice'],
      cancelAt: DateTime.parse(json['cancelAt']),
      refundCoupon: json['refundCoupon'],
      refundPoint: json['refundPoint'],
    );
  }
}

class Feed {
  Feed();

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed();
  }
}
