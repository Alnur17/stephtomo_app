class Api {
  /// base url

  static const baseUrl = "192.168.10.204:5000/api";


  ///auth
  static const signUp = "$baseUrl/auth/create-athlete";
  static const login = "$baseUrl/auth/login";
  //static const changePassword = "$baseUrl/auth/change-password";
  static const forgotPassword = "$baseUrl/auth/send-otp"; //
  static const otpVerify = "$baseUrl/auth/verify-otp";
  static const sentOtp = "$baseUrl/auth/send-otp";
  static const resetForgottenPassword = "$baseUrl/auth/reset-forgotten-password";
  //static  profileExtra({required userId}) => "$baseUrl/users/$userId";
  //static  profileUpdate({required userId}) => "$baseUrl/general-users/$userId";

  ///submit
  static  getSubmit({required categoryId, required userId}) => "$baseUrl/submissions?categoryId=$categoryId&limit=90000&authorRoleBaseId=$userId";
   static const submissions = "$baseUrl/submissions";

  ///category
  static const getCategory = "$baseUrl/category?sortBy=serialNumber&sortOrder=asc&limit=9000000";

  ///allText fields
  static const textFields = "$baseUrl/all-text-fields";

  ///notification
  static const notification = "$baseUrl/notification/send-notification-by-user";


}