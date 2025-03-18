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
    required this.id,
    required this.conference,
    required this.name,
    required this.image,
    required this.mascot,
    required this.city,
    required this.state,
    required this.division,
    required this.type,
    required this.athleticPage,
    required this.staffDirectory,
    required this.idCamp,
    required this.coach,
    required this.v,
  });

  final String? id;
  final String? conference;
  final String? name;
  final String? image;
  final String? mascot;
  final String? city;
  final String? state;
  final String? division;
  final String? type;
  final String? athleticPage;
  final String? staffDirectory;
  final String? idCamp;
  final Coach? coach;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      conference: json["conference"],
      name: json["name"],
      image: json["image"],
      mascot: json["mascot"],
      city: json["city"],
      state: json["state"],
      division: json["division"],
      type: json["type"],
      athleticPage: json["athletic_page"],
      staffDirectory: json["staff_directory"],
      idCamp: json["id_camp"],
      coach: json["coach"] == null ? null : Coach.fromJson(json["coach"]),
      v: json["__v"],
    );
  }

}

class Coach {
  Coach({
    required this.name,
    required this.position,
    required this.email,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    required this.isDeleted,
    required this.isBlocked,
    required this.image,
    required this.id,
  });

  final String? name;
  final String? position;
  final String? email;
  final String? twitter;
  final String? instagram;
  final String? facebook;
  final bool? isDeleted;
  final bool? isBlocked;
  final String? image;
  final String? id;

  factory Coach.fromJson(Map<String, dynamic> json){
    return Coach(
      name: json["name"],
      position: json["position"],
      email: json["email"],
      twitter: json["twitter"],
      instagram: json["instagram"],
      facebook: json["facebook"],
      isDeleted: json["is_deleted"],
      isBlocked: json["is_blocked"],
      image: json["image"],
      id: json["_id"],
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
