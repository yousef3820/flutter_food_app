import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_response_model.dart';
import 'package:flutter_food_app/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:meta/meta.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  final GetAllProductsUsecase getAllProductsUsecase =
      locator<GetAllProductsUsecase>();
  GetAllProductsCubit() : super(GetAllProductsInitial());

  getAllProducts() async {
    emit(GetAllProductsLoading());
    final result = await getAllProductsUsecase.call();

    result.fold(
      (failure) =>
          emit(GetAllProductsFailure(errorMessage: failure.errorMessage)),
      (success) => emit(GetAllProductsSuccess(products: success)),
    );
  }
}
