import 'package:shared_preferences/shared_preferences.dart';

Future<bool> SaveURLPreference(String url) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("url", url);
  return prefs.commit();
}