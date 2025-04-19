import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tudy/config/core_providers.dart';
import 'package:tudy/features/auth/domain/repositories/auth_repository.dart';
import '../repositories/auth_repository_impl.dart';
import 'datasource_providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthRepositoryImpl(
    tokenStorage: tokenStorage,
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}, name: 'AuthRepository');
