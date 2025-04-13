import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/core/storages/hive_storage.dart';
import 'package:tudy/core/widgets/error_dialog_widget.dart';
import 'package:tudy/features/home/presentation/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();
  runApp(const ProviderScope(child: TudyApp()));
}

class TudyApp extends StatelessWidget {
  const TudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tudy App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Stack(children: [HomeScreen(), ErrorDialogWidget()]),
    );
  }
}
