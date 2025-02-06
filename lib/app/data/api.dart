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

  static const collegeData = "$baseUrl/colleges"; //done

  ///showBookMarked
  static const bookMarked = "$baseUrl/college-bookmarks"; // done

  ///Create BookMarked
  static const addBookMark = "$baseUrl/college-bookmarks"; //done

  /// upload video
  static const uploadVideo = "$baseUrl/videos"; // done

  ///video data
  static const videoData = "$baseUrl/videos"; // done

  ///video delete by id
  static String deleteVideo({required String id}) => "$baseUrl/videos/$id"; //done

  static String updateVideo({required String id}) => "$baseUrl/videos/$id"; //done

  static String allEmail = "$baseUrl/emails"; // done

}