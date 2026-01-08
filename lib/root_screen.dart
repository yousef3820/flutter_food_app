import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/auth/presentation/screens/profile_screen.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:flutter_food_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter_food_app/features/favorites/presentation/cubits/cubit/toggle_favorites_cubit.dart';
import 'package:flutter_food_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_food_app/features/favorites/presentation/screens/favorites_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  final List<bool> _pageLoaded = [true, false, false, false];

  late final ToggleFavoritesCubit favoritesCubit;
  late final CartCubit cartCubit;
  @override
  void initState() {
    super.initState();
    favoritesCubit = ToggleFavoritesCubit()..getUserFavorites();
    cartCubit = CartCubit()..getCartData();
  }

  @override
  void dispose() {
    favoritesCubit.close();
    cartCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cartCubit),
        BlocProvider.value(value: favoritesCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,

        body: IndexedStack(
          index: currentIndex,
          children: [
            _pageLoaded[0] ? const HomeScreen() : const SizedBox(),

            _pageLoaded[1] ? const CartScreen() : const SizedBox(),

            _pageLoaded[2] ? const FavoritesScreen() : const SizedBox(),

            _pageLoaded[3] ? const ProfileScreen() : const SizedBox(),
          ],
        ),

        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.flip,
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 10,
          curveSize: 85,
          color: Colors.white60,
          activeColor: Colors.white,
          items:  [
            TabItem(icon: Icons.home_filled, title: "Home".tr()),
            TabItem(icon: Icons.shopping_bag, title: "Cart".tr()),
            TabItem(icon: Icons.favorite, title: "Favorites".tr()),
            TabItem(icon: Icons.person, title: "Profile".tr()),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
              _pageLoaded[index] = true;
            });
          },
        ),
      ),
    );
  }
}
