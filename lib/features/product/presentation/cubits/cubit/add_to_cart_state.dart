part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

class AddToCartInitial extends AddToCartState {}
class AddToCartLoading extends AddToCartState {}
class AddToCartSuccess extends AddToCartState {
  final AddToCartResponseModel response;
  AddToCartSuccess(this.response);
}
class AddToCartFailure extends AddToCartState {
  final String message;
  AddToCartFailure(this.message);
}

