import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageFunctions {
  //* To Store Email
  static storeEmail(String email) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString("EMAIL_KEY", email);
  }

  //* To STore Name
  static storeName(String name) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString("NAME_KEY", name);
  }

  //* To Store Token
  static storeToken(String token) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString("TOKEN_KEY", token);
  }

  //* To Store userID
  static storeUserID(String userID) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString("USER_ID_KEY", userID);
  }

  //* To STore Auth STatus
  static storeAuth(bool status) async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setBool("AUTH_STATUS", status);
  }

  //* To Get Auth Status
  static Future<bool?> getAuth() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool("AUTH_STATUS");
  }

  //* To Get Email
  static Future<String?> getEmail() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString("EMAIL_KEY");
  }

  //* To Get Name
  static Future<String?> getName() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString("NAME_KEY");
  }

  //* To Get Token
  static Future<String?> getToken() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString("TOKEN_KEY");
  }

  //* To Get userID
  static Future<String?> getUserID() async {
    final SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString("USER_ID_KEY");
  }

  LocalStorageFunctions._();
}
