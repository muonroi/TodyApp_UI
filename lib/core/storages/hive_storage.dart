import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tudy/features/auth/data/models/user_model.dart';

class HiveStorage {
  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(UserModelAdapter());
  }
}
