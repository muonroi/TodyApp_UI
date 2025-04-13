import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel userModel);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String userBoxName = 'user_box';

  @override
  Future<void> cacheUser(UserModel userModel) async {
    final box = await Hive.openBox<UserModel>(userBoxName);
    await box.put('cached_user', userModel);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final box = await Hive.openBox<UserModel>(userBoxName);
    return box.get('cached_user');
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox<UserModel>(userBoxName);
    await box.delete('cached_user');
  }
}
