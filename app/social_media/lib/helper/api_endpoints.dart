class ApiEndpoints {
  static const IP = "https://social-media-app-1cih.onrender.com";
  //* User
  static const String register = '$IP/api/v1/user/register';
  static const String login = '$IP/api/v1/user/login';

  //* Wallet
  static const String walletRecharge = '$IP/api/v1/wallet/recharge';
  static String walletBalance(String id) =>
      '$IP/api/v1/wallet/get-balance?id=$id';

  //* Account
  static String accountInfo(String id) => '$IP/api/v1/account/?id=$id';
  static const String accountPurchase = '$IP/api/v1/account/purchase';
  static const String accountFollow = '$IP/api/v1/account/follow';
  static String accountSearch(String id) => '$IP/api/v1/account/search?id=$id';

  //* Videos
  static String videoUpload = "$IP/api/v1/videos/upload";
  static String videosByUser(String id) => '$IP/api/v1/videos/?id=$id';
  static String videosFollowing(String id) =>
      '$IP/api/v1/videos/following/?id=$id';
  static String cloudinaryURL = '$IP/api/v1/videos/cloudinary';

  //* Private constructor to prevent instantiation.
  ApiEndpoints._();
}
