import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobbund/controller/apiHelper.dart';

//local authorization class
class SharedPreferencesUtils{
  static SharedPreferences preferences;

  SharedPreferencesUtils(SharedPreferences pref) {
    preferences = pref;
  }

  static Future<SharedPreferencesUtils> getInstance() async {
     preferences = await SharedPreferences.getInstance();
    return new SharedPreferencesUtils(preferences);
  }

//  Future<User> getLoginInfo() async {
//    Map<String, dynamic> map;
//    map = json.decode(await preferences.getString("userInfo"));
//    return User.fromJson(map);
//  }

  //session id save when login
  void saveLoginInfo(String _sessionId) async {
    await preferences.setString('sessionId', _sessionId);
  }

  //session id
  Future<String> getLodinInfo() async {
    return preferences.getString('sessionId');
  }

  //logout
  Future<bool> logoout()async{
    String _seesionId = await getLodinInfo();
    String _endPoint = "logout/$_seesionId";
    Map<String, String> _params;
    var response = await ApiHelper().doBodyPostRequest(_endPoint, _params);
    if(response['error'] != null){
      return false;
    }
    await preferences.remove("sessionId");
    return true;
  }

  //clear total session
  void clearAll() async {
    await preferences.clear();
  }
}