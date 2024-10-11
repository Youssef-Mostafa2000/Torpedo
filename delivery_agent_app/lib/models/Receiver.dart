class Receiver {
  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? district;
  final String? notes;

  Receiver({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.address,
    required this.district,
    this.notes,
  });

  factory Receiver.fromJson(json) {
    return Receiver(
      id: json['id'],
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? 0,
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      address: json['address'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name ?? '',
      'phoneNumber': phoneNumber ?? 0,
      'city': city ?? '',
      'district': district ?? '',
      'address': address ?? '',
      'notes': notes ?? '',
    };
  }
}
