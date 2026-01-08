import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/login/login_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/login/login_reponse_model.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase = locator<LoginUsecase>();
  final LocalDatasource localDatasource = locator<LocalDatasource>();
  LoginCubit() : super(LoginInitial());

  login(LoginRequestModel loginUser) async {
    emit(LoginLoading());
    final result = await loginUsecase.call(loginUser);
    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.errorMessage)),
      (success) async {
        await localDatasource.storeSecureData('token', success.data!.token);
        emit(LoginSucces(loginedUser: success));
      },
    );
  }
}
