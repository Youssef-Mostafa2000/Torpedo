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
      name: json['name'],
      phoneNumber: json['phoneNumber'].toString(),
      city: json['city'],
      district: json['district'],
      address: json['address'],
      notes: json['notes'],
    );
  }
}
