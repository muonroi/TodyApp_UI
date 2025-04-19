import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/config/core_providers.dart';
import 'package:tudy/features/home/data/models/category_model.dart';
import 'package:tudy/features/home/data/repositories/home_repository.dart';
import 'package:tudy/features/home/presentation/widgets/quick_add_bar.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final baseService = ref.watch(baseServiceProvider);
  return HomeRepositoryImpl(baseService: baseService);
});
final categoryListProvider = Provider<List<Category>>((ref) {
  return mockCategories;
});
