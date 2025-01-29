class VideoModel {
  VideoModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory VideoModel.fromJson(Map<String, dynamic> json){
    return VideoModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.athlete,
    required this.title,
    required this.url,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Athlete? athlete;
  final String? title;
  final String? url;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      athlete: json["athlete"] == null ? null : Athlete.fromJson(json["athlete"]),
      title: json["title"],
      url: json["url"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Athlete {
  Athlete({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.isEmailVerified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? email;
  final String? password;
  final String? role;
  final bool? isEmailVerified;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Athlete.fromJson(Map<String, dynamic> json){
    return Athlete(
      id: json["_id"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      isEmailVerified: json["is_email_verified"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
