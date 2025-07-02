// PUBLIC_INTERFACE
class Hotel {
  /// Hotel data model representing a hotel listing
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String imageUrl;
  final List<String> amenities;
  final String? description;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.amenities,
    this.description,
  });

  // Factory constructor for creating Hotel from JSON
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      amenities: List<String>.from(json['amenities'] ?? []),
      description: json['description'],
    );
  }

  // Convert Hotel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'amenities': amenities,
      'description': description,
    };
  }
}
