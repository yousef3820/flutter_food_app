part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileSuccess extends ProfileState {
  final ProfileResponseModel profileData;

  ProfileSuccess({required this.profileData});
}
final class UpdateProfileLoading extends ProfileState {}
final class UpdateProfileSuccess extends ProfileState {
  final UpdateProfileResponseModel profileData;

  UpdateProfileSuccess({required this.profileData});
}
final class LogoutLoading extends ProfileState {}
final class LogoutSuccess extends ProfileState {
  final LogoutResponseModel profileData;

  LogoutSuccess({required this.profileData});
}
class LogoutFailure extends ProfileState {
  final String error;
  LogoutFailure(this.error);
}
final class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure({required this.errorMessage});
}
