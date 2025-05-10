class ApiEndpoints {
  static const IP = "172.20.10.3";
  //* User
  static const String register = 'http://${IP}/api/v1/user/register';
  static const String login = 'http://${IP}/api/v1/user/login';

  //* Wallet
  static const String walletRecharge = 'http://${IP}/api/v1/wallet/recharge';
  static String walletBalance(String id) =>
      'http://${IP}/api/v1/wallet/get-balance?id=$id';

  //* Account
  static String accountInfo(String id) => 'http://${IP}/api/v1/account/?id=$id';
  static const String accountPurchase = 'http://${IP}/api/v1/account/purchase';
  static const String accountFollow = 'http://${IP}/api/v1/account/follow';
  static  String accountSearch(String id) => 'http://${IP}/api/v1/account/search?id=$id';

  //* Videos
  static String videoUpload = "http://${IP}/api/v1/videos/upload";
  static String videosByUser(String id) => 'http://${IP}/api/v1/videos/?id=$id';
  static String videosFollowing(String id) =>
      'http://${IP}/api/v1/videos/following/?id=$id';
  static String cloudinaryURL = 'http://$IP/api/v1/videos/cloudinary';

  //* Private constructor to prevent instantiation.
  ApiEndpoints._();
}
