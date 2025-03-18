class SubscriptionPackagesModel {
  SubscriptionPackagesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory SubscriptionPackagesModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPackagesModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.packageName,
    required this.price,
    required this.messages,
    required this.updatedAt,
  });

  final String? id;
  final String? packageName;
  final double? price;
  final int? messages;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      packageName: json["package_name"],
      price: (json["price"] is int)
          ? (json["price"] as int).toDouble()
          : (json["price"] as double?),
      messages: json["messages"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}
