import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/register/register_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/register/register_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase registerUsecase = locator<RegisterUsecase>();
  final LocalDatasource localDatasource =  locator<LocalDatasource>();
  RegisterCubit() : super(RegisterInitial());

  register(RegisterRequestModel registerUser) async {
    emit(RegisterLoading());
    final result = await registerUsecase.call(registerUser);
    result.fold(
      (failure) => emit(RegisterFailure(errorMessage: failure.errorMessage)),
      (success) async{
        await localDatasource.storeSecureData('token' , success.data.token);
        emit(RegisterSuccess(response: success));
      },
    );
  }
}
