import 'package:shared_preferences/shared_preferences.dart';
import 'package:api_app/models/student.dart';

enum PrefKeys {loggedIn, id, fullName, email, gender, token, isActive}

class SharedPrefController {

  SharedPrefController._();
  late SharedPreferences _sharedPreferences;

  static SharedPrefController? _instance;

  factory SharedPrefController(){
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPrefs() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void>
  save (Student student) async{
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(PrefKeys.id.name, student.id);
    await _sharedPreferences.setString(PrefKeys.fullName.name, student.fullName);
    await _sharedPreferences.setString(PrefKeys.email.name, student.email);
    await _sharedPreferences.setString(PrefKeys.gender.name, student.gender);
    await _sharedPreferences.setString(PrefKeys.token.name, 'Bearer ${student.token}');
    await _sharedPreferences.setBool(PrefKeys.isActive.name, student.isActive);
  }

  T? getValueFor<T>({required String key}){
    if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> clear() async => await _sharedPreferences.clear();
}