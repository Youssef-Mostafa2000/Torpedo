class Item {
  final int? id;
  final String? name;
  final int? quantity;
  final double? price;
  final String? weight;
  final String? description;
  final String? referenceNumber;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.weight,
    required this.description,
    required this.referenceNumber,
  });

  factory Item.fromJson(json) {
    return Item(
      id: json['id'],
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 1,
      weight: json['weight'] ?? 1,
      description: json['description'] ?? '',
      referenceNumber: json['referenceNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name ?? '',
      'price': price ?? 0,
      'quantity': quantity ?? 1,
      'weight': weight ?? 1,
      'description': description ?? '',
      'referenceNumber': referenceNumber ?? '',
    };
  }
}
