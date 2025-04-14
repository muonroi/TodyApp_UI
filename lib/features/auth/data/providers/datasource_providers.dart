import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/config/core_providers.dart';
import 'package:tudy/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tudy/features/auth/data/datasources/auth_remote_data_source.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final baseService = ref.watch(baseServiceProvider);
  return AuthRemoteDataSourceImpl(baseService: baseService);
}, name: 'AuthRemoteDataSource');

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl();
}, name: 'AuthLocalDataSource');
