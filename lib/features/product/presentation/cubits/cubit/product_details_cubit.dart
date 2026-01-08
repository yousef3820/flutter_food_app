// product_details_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:flutter_food_app/core/service_locator.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/side_options/get_side_options_response_model.dart';
import 'package:flutter_food_app/features/product/data/models/response_models/toppings/get_toppings_response_model.dart';
import 'package:flutter_food_app/features/product/domain/usecases/get_side_options_usecase.dart';
import 'package:flutter_food_app/features/product/domain/usecases/get_toppings_usecase.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetToppingsUsecase getToppingsUsecase = locator<GetToppingsUsecase>();
  final GetSideOptionsUsecase getSideOptionsUsecase = locator<GetSideOptionsUsecase>();
  
  // Store loaded data
  GetToppingsResponseModel? _toppings;
  GetSideOptionsResponseModel? _sideOptions;
  
  ProductDetailsCubit() : super(ProductDetailsInitial());

  // Load all data
  loadAllData() async {
    emit(ProductDetailsAllLoading());
    
    try {
      // Load both in parallel
      final toppingsResult = await getToppingsUsecase.call();
      final sideOptionsResult = await getSideOptionsUsecase.call();
      
      toppingsResult.fold(
        (failure) => emit(ProductDetailsFailure(errorMessage: failure.errorMessage)),
        (success) {
          _toppings = success;
          sideOptionsResult.fold(
            (failure) => emit(ProductDetailsFailure(errorMessage: failure.errorMessage)),
            (success) {
              _sideOptions = success;
              emit(ProductDetailsAllSuccess(
                toppings: _toppings!,
                sideOptions: _sideOptions!,
              ));
            },
          );
        },
      );
    } catch (e) {
      emit(ProductDetailsFailure(errorMessage: "Failed to load data: ${e.toString()}"));
    }
  }
 
}