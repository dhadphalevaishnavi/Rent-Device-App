class Device {
  String? id;
  String? category;
  String? name;
  List<String>? imageUrl;
  bool? isAvailable;

  Device(
      {String? id,
      String? category,
      String? name,
      List<String>? imageUrl,
      bool? isAvailable}) {
    if (id != null) {
      this.id = id;
    }
    if (category != null) {
      this.category = category;
    }
    if (name != null) {
      this.name = name;
    }
    if (imageUrl != null) {
      this.imageUrl = imageUrl;
    }
    if (isAvailable != null) {
      this.isAvailable = isAvailable;
    }
  }

  factory Device.fromJson(Map<String, dynamic> json) {
    final imageUrlTemp = json['imageUrl'] as List<dynamic>;
    return Device(
        id: json['id'],
        category: json['category'],
        name: json['name'],
        isAvailable: json['available'],
        imageUrl: imageUrlTemp.map((e) => e.toString()).toList());
  }


}

