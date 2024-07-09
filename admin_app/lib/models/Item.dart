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
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      weight: json['weight'],
      description: json['description'],
      referenceNumber: json['referenceNumber'],
    );
  }
}
