class User {
  final int id;
  final String email;
  final String? password;
  final String? name;
  final String? phoneNumber;
  final String? provider;
  final String? thirdpartyId;
  final int point;
  final int earnPoint;
  final String? birthday;
  final String nickname;
  final String? gender;
  final String profilePhoto;
  final String? location;
  final String? catchphrase;
  final String? introduction;
  final bool agreementTermsOfService;
  final bool agreementCollectPersonal;
  final bool agreementMarketing;
  final String role;
  final String? zipCode;
  final String? address;
  final String? detailAddress;
  final String? geoLocation;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    this.password,
    this.name,
    this.phoneNumber,
    this.provider,
    this.thirdpartyId,
    required this.point,
    required this.earnPoint,
    this.birthday,
    required this.nickname,
    this.gender,
    required this.profilePhoto,
    this.location,
    this.catchphrase,
    this.introduction,
    required this.agreementTermsOfService,
    required this.agreementCollectPersonal,
    required this.agreementMarketing,
    required this.role,
    this.zipCode,
    this.address,
    this.detailAddress,
    this.geoLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      provider: json['provider'],
      thirdpartyId: json['thirdpartyId'],
      point: json['point'],
      earnPoint: json['earnPoint'],
      birthday: json['birthday'],
      nickname: json['nickname'],
      gender: json['gender'],
      profilePhoto: json['profilePhoto'],
      location: json['location'],
      catchphrase: json['catchphrase'],
      introduction: json['introduction'],
      agreementTermsOfService: json['agreementTermsOfService'],
      agreementCollectPersonal: json['agreementCollectPersonal'],
      agreementMarketing: json['agreementMarketing'],
      role: json['role'],
      zipCode: json['zipCode'],
      address: json['address'],
      detailAddress: json['detailAddress'],
      geoLocation: json['geoLocation'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class NonMember {
  NonMember();

  factory NonMember.fromJson(Map<String, dynamic> json) {
    return NonMember();
  }
}

class Coupon {
  final int id;
  final String name;
  final String contents;
  final int price;
  final String expireDuration;
  final int minOrderPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  Coupon({
    required this.id,
    required this.name,
    required this.contents,
    required this.price,
    required this.expireDuration,
    required this.minOrderPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      name: json['name'],
      contents: json['contents'],
      price: json['price'],
      expireDuration: json['expireDuration'],
      minOrderPrice: json['minOrderPrice'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Gift {
  Gift();

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift();
  }
}
