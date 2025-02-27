class SchoolModel {
  SchoolModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SchoolModel.fromJson(Map<String, dynamic> json){
    return SchoolModel(
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
    required this.image,
    required this.id,
    required this.conference,
    required this.name,
    required this.mascot,
    required this.city,
    required this.state,
    required this.division,
    required this.type,
    required this.athleticPage,
    required this.v,
    required this.coach,
  });

  final String? image;
  final String? id;
  final String? conference;
  final String? name;
  final String? mascot;
  final String? city;
  final String? state;
  final String? division;
  final String? type;
  final String? athleticPage;
  final int? v;
  final Coach? coach;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      image: json["image"],
      id: json["_id"],
      conference: json["conference"],
      name: json["name"],
      mascot: json["mascot"],
      city: json["city"],
      state: json["state"],
      division: json["division"],
      type: json["type"],
      athleticPage: json["athletic_page"],
      v: json["__v"],
      coach: json["coach"] == null ? null : Coach.fromJson(json["coach"]),
    );
  }

}

class Coach {
  Coach({
    required this.id,
    required this.school,
    required this.name,
    required this.image,
    required this.position,
    required this.email,
    required this.twitter,
    required this.instagram,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? school;
  final String? name;
  final String? image;
  final String? position;
  final String? email;
  final String? twitter;
  final String? instagram;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Coach.fromJson(Map<String, dynamic> json){
    return Coach(
      id: json["_id"],
      school: json["school"],
      name: json["name"],
      image: json["image"],
      position: json["position"],
      email: json["email"],
      twitter: json["twitter"],
      instagram: json["instagram"],
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
