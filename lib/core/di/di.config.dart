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

import '../../features/forget_password/data/contracts/forget_password_online_datasource.dart'
    as _i274;
import '../../features/forget_password/data/data_sources/forget_password_online_datasource_impl.dart'
    as _i505;
import '../../features/forget_password/data/repositories/forget_password_repository_impl.dart'
    as _i787;
import '../../features/forget_password/domain/repositories/forget_password_repository.dart'
    as _i129;
import '../../features/forget_password/domain/usecases/create_new_pass_use_case.dart'
    as _i1065;
import '../../features/forget_password/domain/usecases/forget_password_usecase.dart'
    as _i535;
import '../../features/forget_password/domain/usecases/reset_code_use_case.dart'
    as _i248;
import '../../features/forget_password/presentaion/create_new_pass_screen/view_model/create_new_password_view_model.dart'
    as _i362;
import '../../features/forget_password/presentaion/forgot_password_screen/view_model/foget_password_view_model.dart'
    as _i885;
import '../../features/forget_password/presentaion/otp_verification_screen/view_model/reset_code_view_model.dart'
    as _i910;
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
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i26.UserProvider>(() => _i26.UserProvider());
    gh.singleton<_i119.ApiManager>(() => _i119.ApiManager(gh<_i361.Dio>()));
    gh.factory<_i274.ForgetPasswordOnlineDatasource>(
        () => _i505.ForgetPasswordOnlineDatasourceImpl(gh<_i119.ApiManager>()));
    gh.factory<_i129.ForgetPasswordRepository>(() =>
        _i787.ForgetPasswordRepositoryImpl(
            gh<_i274.ForgetPasswordOnlineDatasource>()));
    gh.factory<_i1065.CreateNewPasswordUseCase>(() =>
        _i1065.CreateNewPasswordUseCase(gh<_i129.ForgetPasswordRepository>()));
    gh.factory<_i535.ForgetPasswordUseCase>(() =>
        _i535.ForgetPasswordUseCase(gh<_i129.ForgetPasswordRepository>()));
    gh.factory<_i248.ResetCodeUseCase>(
        () => _i248.ResetCodeUseCase(gh<_i129.ForgetPasswordRepository>()));
    gh.factory<_i362.CreateNewPassWordViewModel>(() =>
        _i362.CreateNewPassWordViewModel(
            gh<_i1065.CreateNewPasswordUseCase>()));
    gh.factory<_i910.OtpVerifyViewModel>(() => _i910.OtpVerifyViewModel(
          gh<_i535.ForgetPasswordUseCase>(),
          gh<_i248.ResetCodeUseCase>(),
        ));
    gh.factory<_i885.ForgetPassWordViewModel>(
        () => _i885.ForgetPassWordViewModel(gh<_i535.ForgetPasswordUseCase>()));
    return this;
  }
}

class _$DioModule extends _i200.DioModule {}
