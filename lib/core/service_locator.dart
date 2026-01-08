import 'package:dio/dio.dart';
import 'package:flutter_food_app/core/network/dio_consumer.dart';
import 'package:flutter_food_app/features/auth/data/datasources/local_datasource.dart';
import 'package:flutter_food_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:flutter_food_app/features/auth/data/repos/get_profile_data_repo_impl.dart';
import 'package:flutter_food_app/features/auth/data/repos/login_repo_impl.dart';
import 'package:flutter_food_app/features/auth/data/repos/logout_repo_impl.dart';
import 'package:flutter_food_app/features/auth/data/repos/register_repo_impl.dart';
import 'package:flutter_food_app/features/auth/data/repos/update_profile_data_repo_impl.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/get_profile_data_usecase.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_food_app/features/auth/domain/usecases/update_profile_data_usecase.dart';
import 'package:flutter_food_app/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:flutter_food_app/features/cart/data/repos/delete_from_cart_repo_impl.dart';
import 'package:flutter_food_app/features/cart/data/repos/get_cart_data_repo_impl.dart';
import 'package:flutter_food_app/features/cart/domain/usecases/delete_from_cart_usecase.dart';
import 'package:flutter_food_app/features/cart/domain/usecases/get_cart_data_usecase.dart';
import 'package:flutter_food_app/features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'package:flutter_food_app/features/favorites/data/repos/get_user_favorites_repo_impl.dart';
import 'package:flutter_food_app/features/favorites/data/repos/toggle_favorites_repo_impl.dart';
import 'package:flutter_food_app/features/favorites/domain/usecases/get_user_favorites_usecase.dart';
import 'package:flutter_food_app/features/favorites/domain/usecases/toggle_favorites_usecase.dart';
import 'package:flutter_food_app/features/home/data/datasources/products_remote_data_source.dart';
import 'package:flutter_food_app/features/home/data/repos/get_all_products_repo_impl.dart';
import 'package:flutter_food_app/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_food_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:flutter_food_app/features/product/data/repos/add_to_cart_repo_impl.dart';
import 'package:flutter_food_app/features/product/data/repos/get_side_options_repo_impl.dart';
import 'package:flutter_food_app/features/product/data/repos/get_toppings_repo_impl.dart';
import 'package:flutter_food_app/features/product/domain/usecases/add_to_cart_usecase.dart';
import 'package:flutter_food_app/features/product/domain/usecases/get_side_options_usecase.dart';
import 'package:flutter_food_app/features/product/domain/usecases/get_toppings_usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //local datasource

  locator.registerLazySingleton<LocalDatasource>(() => LocalDatasource());

  locator.registerLazySingleton<Dio>(() => Dio());

  locator.registerLazySingleton<DioConsumer>(
    () => DioConsumer(dio: locator<Dio>()),
  );

  locator.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasource(api: locator<DioConsumer>()),
  );
  /////////////////////////////////////////AUTH///////////////////////////////////////////////
  //Register
  locator.registerLazySingleton<RegisterRepoImpl>(
    () => RegisterRepoImpl(dataSource: locator<RemoteDatasource>()),
  );

  locator.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(registerUsecase: locator<RegisterRepoImpl>()),
  );

  //Login
  locator.registerLazySingleton<LoginRepoImpl>(
    () => LoginRepoImpl(remoteDatasource: locator<RemoteDatasource>()),
  );

  locator.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(loginRepo: locator<LoginRepoImpl>()),
  );

  //logout

  locator.registerLazySingleton<LogoutRepoImpl>(
    () => LogoutRepoImpl(remoteDatasource: locator<RemoteDatasource>()),
  );

  locator.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(logoutRepo: locator<LogoutRepoImpl>()),
  );

  //getProfileData

  locator.registerLazySingleton<GetProfileDataRepoImpl>(
    () => GetProfileDataRepoImpl(remoteDatasource: locator<RemoteDatasource>()),
  );

  locator.registerLazySingleton<GetProfileDataUsecase>(
    () => GetProfileDataUsecase(
      getProfileDataRepo: locator<GetProfileDataRepoImpl>(),
    ),
  );

  //updateProfile

  locator.registerLazySingleton<UpdateProfileDataRepoImpl>(
    () => UpdateProfileDataRepoImpl(
      remoteDatasource: locator<RemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<UpdateProfileDataUsecase>(
    () => UpdateProfileDataUsecase(
      updateProfileDataRepo: locator<UpdateProfileDataRepoImpl>(),
    ),
  );

  /////////////////////////////////////////AUTH///////////////////////////////////////////////

  ///////////////////////////////////////Products////////////////////////////////////////////

  locator.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSource(api: locator<DioConsumer>()),
  );

  //get all products

  locator.registerLazySingleton<GetAllProductsRepoImpl>(
    () => GetAllProductsRepoImpl(
      remoteDataSource: locator<ProductsRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<GetAllProductsUsecase>(
    () => GetAllProductsUsecase(
      getAllProductsRepo: locator<GetAllProductsRepoImpl>(),
    ),
  );

  //////////////////////////////////////ProductsDetails////////////////////////////////////////

  locator.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasource(api: locator<DioConsumer>()),
  );

  locator.registerLazySingleton<GetToppingsRepoImpl>(
    () => GetToppingsRepoImpl(
      productRemoteDatasource: locator<ProductRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<GetToppingsUsecase>(
    () => GetToppingsUsecase(getToppingsRepo: locator<GetToppingsRepoImpl>()),
  );

  locator.registerLazySingleton<GetSideOptionsRepoImpl>(
    () => GetSideOptionsRepoImpl(
      productRemoteDatasource: locator<ProductRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<GetSideOptionsUsecase>(
    () => GetSideOptionsUsecase(
      getSideOptionsRepo: locator<GetSideOptionsRepoImpl>(),
    ),
  );
  locator.registerLazySingleton<AddToCartRepoImpl>(
    () => AddToCartRepoImpl(
      productRemoteDatasource: locator<ProductRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<AddToCartUsecase>(
    () => AddToCartUsecase(addTocart: locator<AddToCartRepoImpl>()),
  );

  ////////////////////////////////////////////getcartData/////////////////////////////////////////////////

  locator.registerLazySingleton<CartRemoteDatasource>(
    () => CartRemoteDatasource(api: locator<DioConsumer>()),
  );

  locator.registerLazySingleton<GetCartDataRepoImpl>(
    () => GetCartDataRepoImpl(
      cartRemoteDatasource: locator<CartRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<GetCartDataUsecase>(
    () => GetCartDataUsecase(getCartDataRepo: locator<GetCartDataRepoImpl>()),
  );

  locator.registerLazySingleton<DeleteFromCartRepoImpl>(
    () => DeleteFromCartRepoImpl(
      cartRemoteDatasource: locator<CartRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<DeleteFromCartUsecase>(
    () => DeleteFromCartUsecase(
      deleteFromCartRepo: locator<DeleteFromCartRepoImpl>(),
    ),
  );

  ////////////////////////////////Favorites//////////////////////////////

  locator.registerLazySingleton<FavoritesRemoteDatasource>(
    () => FavoritesRemoteDatasource(api: locator<DioConsumer>()),
  );

  locator.registerLazySingleton<ToggleFavoritesRepoImpl>(
    () => ToggleFavoritesRepoImpl(
      favoritesRemoteDatasource: locator<FavoritesRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<ToggleFavoritesUsecase>(
    () => ToggleFavoritesUsecase(
      toggleFavoritesRepo: locator<ToggleFavoritesRepoImpl>(),
    ),
  );

  locator.registerLazySingleton<GetUserFavoritesRepoImpl>(
    () => GetUserFavoritesRepoImpl(
      favoritesRemoteDatasource: locator<FavoritesRemoteDatasource>(),
    ),
  );

  locator.registerLazySingleton<GetUserFavoritesUsecase>(
    () => GetUserFavoritesUsecase(
      getUserFavoritesRepo: locator<GetUserFavoritesRepoImpl>(),
    ),
  );
}
