import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/login/bloc.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future setIsVip(int number) async {
    await _prefs.setInt("isVip", number);
  }

  static int getIsVip() {
    return _prefs.getInt("isVip") ?? 0;
  }

  static String getFullName() {
    return _prefs.getString("fullname") ?? "";
  }

  static String? getToken() {
    return _prefs.getString("token") ?? "";
  }

  static String? getCity() {
    return _prefs.getString("cityName") ?? "";
  }

  static String getPhone() {
    return _prefs.getString("phone") ?? "";
  }

  static int getCityId() {
    return int.parse(_prefs.getString("cityId") ?? "0");
  }

  static String getImage() {
    return _prefs.getString("image") ??
        "https://img.freepik.com/premium-vector/account-icon-user-icon-vector-graphics_292645-552.jpg?w=1480";
  }

  static Future setImage(String path) async {
    await _prefs.setString("image", path);
  }

  static String getCurrentLocationName() {
    return _prefs.getString("currentLocationName") ?? "مدينتك";
  }

  static Future setCurrentLocationName(String path) async {
    await _prefs.setString("currentLocationName", path);
  }

  static String getCityName() {
    return _prefs.getString("cityName") ?? "";
  }

  static String getCitID() {
    return _prefs.getString("cityId") ?? "";
  }

  static Future setLanguage(String lang) async {
    await _prefs.setString("lang", lang);
  }

  static Future setCityName(String city) async {
    await _prefs.setString("cityName", city);
  }

  static String getLanguage() {
    return _prefs.getString("lang") ?? "";
  }

  static Future saveLoginData(UserData user) async {
    await _prefs.setString("image", user.list.image);
    await _prefs.setInt("id", user.list.id);
    await _prefs.setString("phone", user.list.phone);
    await _prefs.setString("email", user.list.email);
    await _prefs.setString("fullname", user.list.fullname);
    await _prefs.setString("token", user.list.token);
    await _prefs.setString("cityId", user.list.city.id);
    await _prefs.setString("cityName", user.list.city.name);
    await _prefs.setBool("isActive", user.list.isActive);
    await _prefs.setInt("userCartCount", user.list.userCartCount);
    await _prefs.setInt("unreadNotifications", user.list.unreadNotifications);
  }

  // static Future saveCurrentLocation(Position currentLocation) async {
  //   await _prefs.setDouble("latitude", currentLocation.latitude);
  //   await _prefs.setDouble("longitude", currentLocation.longitude);
  // }

  static Future saveCurrentLocationWithNameHome(String location) async {
    await _prefs.setString("location", location);
  }

  static String getCurrentLocationWithNameHome() {
    return _prefs.getString("location") ?? "";
  }

  static Future saveCurrentLocationWithNameMap(String location) async {
    await _prefs.setString("location", location);
  }

  static String getCurrentLocationWithNameMap() {
    return _prefs.getString("location") ?? "";
  }

  static double getLatitude() {
    return _prefs.getDouble("latitude") ?? 0;
  }

  static double getLongitude() {
    return _prefs.getDouble("longitude") ?? 0;
  }

  static Future clearLoginData() async {
    await _prefs.clear();
  }

  static Future removeCityName() async {
    await _prefs.remove("cityName");
  }

  static Future removeLoginData() async {
    await _prefs.remove("image");
    await _prefs.remove("id");
    await _prefs.remove("phone");
    await _prefs.remove("email");
    await _prefs.remove("fullname");
    await _prefs.remove("token");
    await _prefs.remove("cityId");
    await _prefs.remove("cityName");
    await _prefs.remove("isActive");
    await _prefs.remove("userCartCount");
    await _prefs.remove("unreadNotifications");
  }
}
