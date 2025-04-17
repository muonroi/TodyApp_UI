import 'package:hive/hive.dart';
import '../models/login_response_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(LoginResponseModel userModel);
  Future<LoginResponseModel?> getCachedUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String userBoxName = 'user_box';

  @override
  Future<void> cacheUser(LoginResponseModel userModel) async {
    final box = await Hive.openBox<LoginResponseModel>(userBoxName);
    await box.put('cached_user', userModel);
  }

  @override
  Future<LoginResponseModel?> getCachedUser() async {
    final box = await Hive.openBox<LoginResponseModel>(userBoxName);
    return box.get('cached_user');
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox<LoginResponseModel>(userBoxName);
    await box.delete('cached_user');
  }
}
