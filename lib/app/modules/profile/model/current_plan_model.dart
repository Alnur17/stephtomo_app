class CurrentPlanModel {
  CurrentPlanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CurrentPlanModel.fromJson(Map<String, dynamic> json){
    return CurrentPlanModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.user,
    required this.packageName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.price,
  });

  final String? id;
  final String? user;
  final String? packageName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final double? price;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      user: json["user"],
      packageName: json["package_name"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      price: json["price"]?.toDouble(),
    );
  }

}
