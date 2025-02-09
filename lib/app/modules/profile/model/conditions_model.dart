class ConditionsModel {
  ConditionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory ConditionsModel.fromJson(Map<String, dynamic> json){
    return ConditionsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.termsConditions,
    required this.aboutUs,
    required this.privacyPolicy,
    required this.updatedAt,
  });

  final String? id;
  final String? termsConditions;
  final String? aboutUs;
  final String? privacyPolicy;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      termsConditions: json["terms_conditions"],
      aboutUs: json["about_us"],
      privacyPolicy: json["privacy_policy"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
