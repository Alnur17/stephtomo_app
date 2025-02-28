class SchoolBookMarksModel {
  SchoolBookMarksModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SchoolBookMarksModel.fromJson(Map<String, dynamic> json){
    return SchoolBookMarksModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<Datum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.school,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? school;
  final String? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      school: json["school"],
      user: json["user"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Meta {
  Meta({
    required this.total,
  });

  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      total: json["total"],
    );
  }

}
