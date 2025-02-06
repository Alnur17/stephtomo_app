class CollegeBookMarksModel {
  CollegeBookMarksModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CollegeBookMarksModel.fromJson(Map<String, dynamic> json){
    return CollegeBookMarksModel(
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
    required this.college,
    required this.user,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final College? college;
  final String? user;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      college: json["college"] == null ? null : College.fromJson(json["college"]),
      user: json["user"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class College {
  College({
    required this.id,
    required this.image,
    required this.collegeName,
    required this.coachName,
    required this.coachTitle,
    required this.coachEmail,
    required this.facebookLink,
    required this.xLink,
    required this.instagramLink,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? image;
  final String? collegeName;
  final String? coachName;
  final String? coachTitle;
  final String? coachEmail;
  final String? facebookLink;
  final String? xLink;
  final dynamic instagramLink;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory College.fromJson(Map<String, dynamic> json){
    return College(
      id: json["_id"],
      image: json["image"],
      collegeName: json["college_name"],
      coachName: json["coach_name"],
      coachTitle: json["coach_title"],
      coachEmail: json["coach_email"],
      facebookLink: json["facebook_link"],
      xLink: json["x_link"],
      instagramLink: json["instagram_link"],
      isDeleted: json["is_deleted"],
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
