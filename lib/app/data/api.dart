class Api {
  /// base url

  static const baseUrl = "http://192.168.10.204:5000/api";


  ///auth
  static const signUp = "$baseUrl/auth/create-athlete"; //done
  static const login = "$baseUrl/auth/login"; //done
  static const forgotPassword = "$baseUrl/auth/send-otp"; //done
  static const otpVerify = "$baseUrl/auth/verify-otp";  //done
  static const sentOtp = "$baseUrl/auth/send-otp"; //done
  static const resetForgottenPassword = "$baseUrl/auth/reset-forgotten-password"; // done
  static const changePassword = "$baseUrl/auth/change-password"; // done

  static const collegeData = "$baseUrl/colleges"; //done

  ///showBookMarked
  static const bookMarked = "$baseUrl/college-bookmarks"; // done

  ///Create BookMarked
  static const addBookMark = "$baseUrl/college-bookmarks"; //done

  static  removeBookMark(String id) => "$baseUrl/college-bookmarks/$id"; //done

  /// upload video
  static const uploadVideo = "$baseUrl/videos"; // done

  ///video data
  static const videoData = "$baseUrl/videos"; // done

  ///video delete by id
  static String deleteVideo({required String id}) => "$baseUrl/videos/$id"; //done

  static String updateVideo({required String id}) => "$baseUrl/videos/$id"; //done

  static const String allEmail = "$baseUrl/emails"; // done

  static const String writeEmail = "$baseUrl/emails"; //

  ///profile
  static const String profile = "$baseUrl/athletes/me"; //done

  static String editProfile(String id) => "$baseUrl/athletes/$id"; //done

  static String deleteProfile(String id) => "$baseUrl/athletes/$id"; //done

  static const String conditionsPage = "$baseUrl/settings"; //done

}