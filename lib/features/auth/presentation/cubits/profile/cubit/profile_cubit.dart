import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:flutter_food_app/features/auth/data/models/request_models/profile/update_profile_request_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/logout/logout_response_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/get_profile_data/profile_response_model.dart';
import 'package:flutter_food_app/features/auth/data/models/response_models/profile/update_profile/update_profile_response_model.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/get_profile_data_usecase.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/update_profile_data_usecase.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileDataUsecase getProfileDataUsecase =
      locator<GetProfileDataUsecase>();

  final UpdateProfileDataUsecase updateProfileDataUsecase =
      locator<UpdateProfileDataUsecase>();

  final LogoutUsecase logoutUsecase = locator<LogoutUsecase>();

  final LocalDatasource localDatasource = locator<LocalDatasource>();
  ProfileCubit() : super(ProfileInitial());

  getProfileData() async {
    emit(ProfileLoading());
    final result = await getProfileDataUsecase.call();

    result.fold(
      (failure) => emit(ProfileFailure(errorMessage: failure.errorMessage)),
      (success) => emit(ProfileSuccess(profileData: success)),
    );
  }

  updateProfileData(UpdateProfileRequestModel updateProfile) async {
    emit(UpdateProfileLoading());
    final response = await updateProfileDataUsecase.call(updateProfile);
    response.fold(
      (failure) => emit(ProfileFailure(errorMessage: failure.errorMessage)),
      (success) {
        emit(UpdateProfileSuccess(profileData: success));
        getProfileData();
      },
    );
  }

  logout() async {
    emit(LogoutLoading());
    final response = await logoutUsecase.call();
    response.fold(
      (failure) => emit(LogoutFailure(failure.errorMessage)),
      (success) async{
        await localDatasource.deleteSecureData("token");
        emit(LogoutSuccess(profileData: success));
      },
    );
  }
}
