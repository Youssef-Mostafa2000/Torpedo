class Address {
  final int? id;
  final String? detailedAddress;
  final String? city;
  final String? district;

  Address({
    required this.id,
    required this.detailedAddress,
    required this.city,
    required this.district,
  });

  factory Address.fromJson(json) {
    return Address(
      id: json['id'],
      detailedAddress: json['detailedAddress'],
      city: json['city'],
      district: json['district'],
    );
  }
}
