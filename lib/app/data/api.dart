class Api {
  /// base url

  static const baseUrl = "http://159.223.184.53:5009/api";

  ///auth
  static const signUp = "$baseUrl/auth/create-athlete"; //done
  static const login = "$baseUrl/auth/login"; //done
  static const forgotPassword = "$baseUrl/auth/send-otp"; //done
  static const otpVerify = "$baseUrl/auth/verify-otp"; //done
  static const sentOtp = "$baseUrl/auth/send-otp"; //done
  static const resetForgottenPassword =
      "$baseUrl/auth/reset-forgotten-password"; // done
  static const changePassword = "$baseUrl/auth/change-password"; // done

  ///College Data
  static const schoolData = "$baseUrl/schools"; //done

  ///notifications
  static const notification = "$baseUrl/notifications"; //done

  static updateNotification(String id) => "$baseUrl/notifications/$id"; //

  ///showBookMarked
  static const bookMarked = "$baseUrl/bookmarks"; // done

  ///Create BookMarked
  static const addBookMark = "$baseUrl/bookmarks"; //done

  // static removeBookMark(String id) => "$baseUrl/college-bookmarks/$id"; //done

  /// upload video
  static const uploadVideo = "$baseUrl/videos"; // done

  ///video data
  static const videoData = "$baseUrl/videos"; // done

  ///video delete by id
  static String deleteVideo({required String id}) =>
      "$baseUrl/videos/$id"; //done

  static String updateVideo({required String id}) =>
      "$baseUrl/videos/$id"; //done

  static const String receivedEmail = "$baseUrl/emails/received";

  static const String sentEmail = "$baseUrl/emails/sent"; //done

  static const String writeEmail = "$baseUrl/emails"; //done

  ///profile
  static const String profile = "$baseUrl/athletes/me"; //done

  static const String editProfile = "$baseUrl/athletes"; //done

  static const String deleteProfile = "$baseUrl/athletes"; //done

  static const String conditionsPage = "$baseUrl/settings"; //done

  static String subscription(String planType, String email) =>
      "$baseUrl/subscriptions/create-payment-session?subscription_type=$planType&email=$email"; //done

  static String packages = "$baseUrl/packages"; //done

  static String currentPlan = "$baseUrl/athletes/subscription"; //done
}
