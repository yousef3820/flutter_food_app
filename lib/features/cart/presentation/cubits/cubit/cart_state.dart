part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class GetCartDataLoading extends CartState {}
final class GetCartDataSuccess extends CartState {
  final GetCartResponse cartDetails;

  GetCartDataSuccess({required this.cartDetails});
}
final class DeleteCartItemLoading extends CartState {
  final int deletingItemId;
  DeleteCartItemLoading(this.deletingItemId);
}
final class DeleteCartItemSuccess extends CartState {
  final DeleteFromCartResponseModel cartDetails;

  DeleteCartItemSuccess({required this.cartDetails});
}
final class ClearCartLoading extends CartState {}

final class ClearCartSuccess extends CartState {}

final class CartFailure extends CartState {
  final String errorMessage;

  CartFailure({required this.errorMessage});
}
