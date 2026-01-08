import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/favorites/presentation/cubits/cubit/toggle_favorites_cubit.dart';
import 'package:flutter_food_app/features/home/data/models/response_models/products_data_model.dart';
import 'package:flutter_food_app/features/home/presentation/cubits/get_all_products/cubit/get_all_products_cubit.dart';
import 'package:flutter_food_app/features/home/presentation/widgets/home_shimmer_widget.dart';
import 'package:flutter_food_app/features/home/presentation/widgets/product_card.dart';
import 'package:flutter_food_app/shared/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<ProductsDataModel> _allProducts = [];
  List<ProductsDataModel> _filteredProducts = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() => _filteredProducts = _allProducts);
      return;
    }

    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final name = product.name.toLowerCase();
        final search = query.toLowerCase();

        return name.contains(search);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: SvgPicture.asset(
          "assets/logo/Logo.svg",
          height: 40,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetAllProductsCubit()..getAllProducts(),
          ),
        ],
        child: BlocConsumer<GetAllProductsCubit, GetAllProductsState>(
          listener: (context, state) {
            if (state is GetAllProductsSuccess) {
              _allProducts = state.products.data;
              _filteredProducts = _allProducts;
            }
          },
          builder: (context, state) {
            if (state is GetAllProductsLoading) {
              return buildShimmerHomeScreen(context);
            }

            if (state is GetAllProductsFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GetAllProductsCubit>().getAllProducts();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                      ),
                      child: Text(
                        "Retry".tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is GetAllProductsSuccess) {
              return _buildHomeScreenContent(_filteredProducts, context);
            }

            return buildShimmerHomeScreen(context);
          },
        ),
      ),
    );
  }

  Widget _buildHomeScreenContent(
    List<ProductsDataModel> products,
    BuildContext context,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        _searchController.clear();
        setState(() {
          _filteredProducts = _allProducts;
        });
        context.read<GetAllProductsCubit>().getAllProducts();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  CustomText(
                    text: "welcome_title".tr(),
                    size: 22,
                    weight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    text: "welcome_subtitle".tr(),
                    size: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 15),

                  /// 🔍 SEARCH BAR
                  TextField(
                    controller: _searchController,
                    onChanged: _filterProducts,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search bar title".tr(),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          /// GRID
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: BlocBuilder<ToggleFavoritesCubit, ToggleFavoritesState>(
              builder: (context, favState) {
                final favoritesCubit = context.read<ToggleFavoritesCubit>();

                if (products.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text("No products found".tr()),
                      ),
                    ),
                  );
                }

                return SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];
                    final isFavorite = favoritesCubit.favoriteProductIds
                        .contains(product.id);

                    return ProductCard(
                      product: product,
                      isFavorite: isFavorite,
                    );
                  }, childCount: products.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.61,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 10,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
