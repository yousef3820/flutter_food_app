import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/delete_from_cart_response_model.dart';
import 'package:flutter_food_app/features/cart/data/models/response_models/get_cart_response.dart';
import 'package:flutter_food_app/features/cart/domain/usecases/delete_from_cart_usecase.dart';
import 'package:flutter_food_app/features/cart/domain/usecases/get_cart_data_usecase.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartDataUsecase getCartDataUsecase = locator<GetCartDataUsecase>();
  final DeleteFromCartUsecase deleteFromCartUsecase =
      locator<DeleteFromCartUsecase>();
  CartCubit() : super(CartInitial());

  getCartData() async {
    emit(GetCartDataLoading());
    final response = await getCartDataUsecase.call();
    response.fold(
      (failure) => emit(CartFailure(errorMessage: failure.errorMessage)),
      (success) => emit(GetCartDataSuccess(cartDetails: success)),
    );
  }

  deleteFromCart(int id) async {
    emit(DeleteCartItemLoading(id));

    final response = await deleteFromCartUsecase.call(id);

    response.fold(
      (failure) => emit(CartFailure(errorMessage: failure.errorMessage)),
      (success) {
        emit(DeleteCartItemSuccess(cartDetails: success));
      },
    );
    getCartData();
  }

  Future<void> clearCart(List<int> itemIds) async {
    emit(ClearCartLoading());

    try {
      for (final id in itemIds) {
        final response = await deleteFromCartUsecase.call(id);

        response.fold(
          (failure) => throw Exception(failure.errorMessage),
          (_) {},
        );
      }

      // 🔥 THIS is what makes CartScreen re-render
      emit(ClearCartSuccess());
    } catch (e) {
      emit(CartFailure(errorMessage: e.toString()));
    }
  }
}
