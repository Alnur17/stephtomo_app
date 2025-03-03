class ReceivedEmailModel {
  ReceivedEmailModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ReceivedEmailModel.fromJson(Map<String, dynamic> json){
    return ReceivedEmailModel(
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

  final List<DataTwo> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<DataTwo>.from(json["data"]!.map((x) => DataTwo.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class DataTwo {
  DataTwo({
    required this.signature,
    required this.id,
    required this.from,
    required this.to,
    required this.subject,
    required this.videoUrl,
    required this.body,
    required this.reminderDate,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Signature? signature;
  final String? id;
  final From? from;
  final List<String> to;
  final String? subject;
  final dynamic videoUrl;
  final String? body;
  final dynamic reminderDate;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory DataTwo.fromJson(Map<String, dynamic> json){
    return DataTwo(
      signature: json["signature"] == null ? null : Signature.fromJson(json["signature"]),
      id: json["_id"],
      from: json["from"] == null ? null : From.fromJson(json["from"]),
      to: json["to"] == null ? [] : List<String>.from(json["to"]!.map((x) => x)),
      subject: json["subject"],
      videoUrl: json["video_url"],
      body: json["body"],
      reminderDate: json["reminder_date"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class From {
  From({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.gradYear,
    required this.gpa,
    required this.sport,
    required this.height,
    required this.primaryPosition,
    required this.secondaryPosition,
    required this.bawlingPreference,
    required this.battingPreference,
    required this.throwingPreference,
    required this.clubTeam,
    required this.clubCoachName,
    required this.clubCoachPhone,
    required this.clubCoachEmail,
    required this.intendedMajor,
    required this.ncaaEligibilityNumber,
    required this.address,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;
  final int? gradYear;
  final double? gpa;
  final String? sport;
  final String? height;
  final String? primaryPosition;
  final String? secondaryPosition;
  final String? bawlingPreference;
  final String? battingPreference;
  final String? throwingPreference;
  final String? clubTeam;
  final String? clubCoachName;
  final int? clubCoachPhone;
  final String? clubCoachEmail;
  final String? intendedMajor;
  final String? ncaaEligibilityNumber;
  final String? address;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory From.fromJson(Map<String, dynamic> json){
    return From(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      profileImage: json["profile_image"],
      gradYear: json["grad_year"],
      gpa: json["gpa"],
      sport: json["sport"],
      height: json["height"],
      primaryPosition: json["primary_position"],
      secondaryPosition: json["secondary_position"],
      bawlingPreference: json["bawling_preference"],
      battingPreference: json["batting_preference"],
      throwingPreference: json["throwing_preference"],
      clubTeam: json["club_team"],
      clubCoachName: json["club_coach_name"],
      clubCoachPhone: json["club_coach_phone"],
      clubCoachEmail: json["club_coach_email"],
      intendedMajor: json["intended_major"],
      ncaaEligibilityNumber: json["ncaa_eligibility_number"],
      address: json["address"],
      isDeleted: json["is_deleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Signature {
  Signature({
    required this.name,
    required this.gradYear,
    required this.gpa,
    required this.sport,
    required this.height,
    required this.primaryPosition,
    required this.clubTeam,
    required this.clubCoach,
    required this.clubCoachNumber,
    required this.clubCoachEmail,
  });

  final String? name;
  final int? gradYear;
  final int? gpa;
  final String? sport;
  final String? height;
  final String? primaryPosition;
  final String? clubTeam;
  final String? clubCoach;
  final String? clubCoachNumber;
  final String? clubCoachEmail;

  factory Signature.fromJson(Map<String, dynamic> json){
    return Signature(
      name: json["name"],
      gradYear: json["grad_year"],
      gpa: json["gpa"],
      sport: json["sport"],
      height: json["height"],
      primaryPosition: json["primary_position"],
      clubTeam: json["club_team"],
      clubCoach: json["club_coach"],
      clubCoachNumber: json["club_coach_number"],
      clubCoachEmail: json["club_coach_email"],
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
