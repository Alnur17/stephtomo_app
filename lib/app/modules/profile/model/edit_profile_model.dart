class EditProfileModel {
  EditProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory EditProfileModel.fromJson(Map<String, dynamic> json){
    return EditProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
