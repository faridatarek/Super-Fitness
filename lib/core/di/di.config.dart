// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/register/cubit/register_cubit.dart' as _i250;
import '../../features/auth/register/data/contracts/register_online_datasource.dart'
    as _i305;
import '../../features/auth/register/data/data_sources/register_online_datasource_impl.dart'
    as _i155;
import '../../features/auth/register/data/repos/register_repo_impl.dart'
    as _i566;
import '../../features/auth/register/domain/repos/register_repo.dart' as _i369;
import '../../features/auth/register/domain/usecases/register_usecase.dart'
    as _i276;
import '../network/api_manager.dart' as _i119;
import '../network/network_module.dart' as _i200;
import '../providers/user_provider.dart' as _i26;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i26.UserProvider>(() => _i26.UserProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.singleton<_i119.ApiManager>(() => _i119.ApiManager(
          gh<_i361.Dio>(),
          gh<_i26.UserProvider>(),
        ));
    gh.factory<_i305.RegisterOnlineDataSource>(
        () => _i155.RegisterOnlineDatasourceImpl(gh<_i119.ApiManager>()));
    gh.factory<_i369.RegisterRepo>(
        () => _i566.RegisterRepoImpl(gh<_i305.RegisterOnlineDataSource>()));
    gh.factory<_i276.RegisterUsecase>(
        () => _i276.RegisterUsecase(gh<_i369.RegisterRepo>()));
    gh.factory<_i250.RegisterCubit>(
        () => _i250.RegisterCubit(gh<_i276.RegisterUsecase>()));
    return this;
  }
}

class _$DioModule extends _i200.DioModule {}
