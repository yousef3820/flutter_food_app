import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/product/data/models/request_models/add_to_cart_request_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/cart/add_to_cart_response_model.dart';
import 'package:flutter_food_app/features/product/domain/usecases/add_to_cart_usecase.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUsecase addToCartUsecase = locator<AddToCartUsecase>();

  AddToCartCubit() : super(AddToCartInitial());
  addToCart(AddToCartRequestModel request) async {
    emit(AddToCartLoading());

    final result = await addToCartUsecase.call(request);

    result.fold(
      (failure) => emit(AddToCartFailure(failure.errorMessage)),
      (success) => emit(AddToCartSuccess(success)),
    );
  }
}
