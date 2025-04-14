import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tudy/config/router.dart';
import 'package:tudy/core/storages/hive_storage.dart';
import 'package:tudy/core/widgets/error_dialog_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();

  runApp(const ProviderScope(child: TudyApp()));
}

class TudyApp extends ConsumerWidget {
  const TudyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Tudy App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            const ErrorDialogWidget(),
          ],
        );
      },
    );
  }
}
