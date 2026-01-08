// product_details_state.dart
part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

// Loading states
final class ProductDetailsAllLoading extends ProductDetailsState {}

final class ProductDetailsToppingsLoading extends ProductDetailsState {}

final class ProductDetailsSideoptionsLoading extends ProductDetailsState {}

// Success states
final class ProductDetailsAllSuccess extends ProductDetailsState {
  final GetToppingsResponseModel toppings;
  final GetSideOptionsResponseModel sideOptions;

  ProductDetailsAllSuccess({required this.toppings, required this.sideOptions});
}

final class ProductDetailsToppingsSuccess extends ProductDetailsState {
  final GetToppingsResponseModel toppings;

  ProductDetailsToppingsSuccess({required this.toppings});
}

final class ProductDetailsSideoptionssSuccess extends ProductDetailsState {
  final GetSideOptionsResponseModel sideoptions;

  ProductDetailsSideoptionssSuccess({required this.sideoptions});
}

// Error state
final class ProductDetailsFailure extends ProductDetailsState {
  final String errorMessage;

  ProductDetailsFailure({required this.errorMessage});
}
