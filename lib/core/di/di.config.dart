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

import '../../features/auth/login/data/contracts/offline_dataSource.dart'
    as _i1;
import '../../features/auth/login/data/contracts/online_dataSource.dart'
    as _i124;
import '../../features/auth/login/data/dataSource/offline_dataSource/offline_dataSource_impl.dart'
    as _i1019;
import '../../features/auth/login/data/dataSource/online_dataSource/online_dataSource_impl.dart'
    as _i1020;
import '../../features/auth/login/data/repository_impl/login_repo_impl.dart'
    as _i580;
import '../../features/auth/login/domain/repository/login_repository.dart'
    as _i354;
import '../../features/auth/login/domain/usecases/login_use_case.dart' as _i316;
import '../../features/auth/login/domain/usecases/set_cached_user_use_case.dart'
    as _i639;
import '../../features/auth/login/presentation/view/login_validator/login_validator.dart'
    as _i114;
import '../../features/auth/login/presentation/viewModel/login_viewModel.dart'
    as _i807;
import '../../features/home/chatBot/presentation/viewModel/chatBot_viewModel.dart'
    as _i461;
import '../local/hive/hive_manager.dart' as _i228;
import '../local/providers/user_provider.dart' as _i405;
import '../network/api_manager.dart' as _i119;
import '../network/network_module.dart' as _i200;

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
    gh.factory<_i405.UserProvider>(() => _i405.UserProvider());
    gh.factory<_i114.LoginValidator>(() => _i114.LoginValidator());
    gh.factory<_i461.ChatCubit>(() => _i461.ChatCubit());
    gh.singleton<_i228.HiveManager>(() => _i228.HiveManager());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.factory<_i1.OfflineDataSource>(
        () => _i1019.OfflineDataSourceImpl(gh<_i228.HiveManager>()));
    gh.singleton<_i119.ApiManager>(() => _i119.ApiManager(
          gh<_i361.Dio>(),
          gh<_i405.UserProvider>(),
        ));
    gh.factory<_i124.OnlineDataSource>(
        () => _i1020.OnlineDataSourceImpl(gh<_i119.ApiManager>()));
    gh.factory<_i354.LoginRepository>(() => _i580.LoginRepoImpl(
          gh<_i124.OnlineDataSource>(),
          gh<_i1.OfflineDataSource>(),
        ));
    gh.factory<_i316.LoginUseCase>(
        () => _i316.LoginUseCase(gh<_i354.LoginRepository>()));
    gh.factory<_i639.SetCachedUserUseCase>(
        () => _i639.SetCachedUserUseCase(gh<_i354.LoginRepository>()));
    gh.factory<_i807.LoginViewModel>(() => _i807.LoginViewModel(
          gh<_i316.LoginUseCase>(),
          gh<_i639.SetCachedUserUseCase>(),
          gh<_i114.LoginValidator>(),
        ));
    return this;
  }
}

class _$DioModule extends _i200.DioModule {}
