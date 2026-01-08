import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_app/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:flutter_food_app/features/checkout/presentation/widgets/checkout_details_text.dart';
import 'package:lottie/lottie.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.totalPrice,
    required this.ordersId,
  });
  final double totalPrice;
  final List<int> ordersId;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedMethod = 0;
  bool ischecked = false;
  void showAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 70,
              ),
              SizedBox(height: 20),
              Text(
                "Payment Successful".tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 10),
              Text(
                "checkout success".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Go Back".tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is ClearCartLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 1,
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      "assets/splash/Burger_Lottie_Animation..json",
                      height: 130,
                      width: 130,
                      repeat: true,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "clear items after checkout".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is ClearCartSuccess) {
          Navigator.pop(context);
          showAlert();
          Future.delayed(Duration(milliseconds: 300), () {
            context.read<CartCubit>().getCartData();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary".tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CheckoutDetailsText(
                  title: "Order".tr(),
                  value: "\$${widget.totalPrice}",
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 16,
                ),
                CheckoutDetailsText(
                  title: "Taxes".tr(),
                  value: "\$11.0",
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 16,
                ),
                CheckoutDetailsText(
                  title: "Delivery fees".tr(),
                  value: "\$10.5",
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 16,
                ),
                Divider(thickness: 2),
                CheckoutDetailsText(
                  title: "Total".tr(),
                  value: "\$ ${widget.totalPrice + 10.5 + 11.0}",
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
                CheckoutDetailsText(
                  title: "Estimated delivery time".tr(),
                  value: "15 - 30 mins",
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
                SizedBox(height: 15),
                Text(
                  "Payment methods".tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 40),
                RadioGroup<int>(
                  groupValue: _selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedMethod = value!;
                    });
                  },
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Image.asset("assets/splash/doller.png"),
                        title: Text(
                          "Cash on Delivery".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        trailing: Radio(
                          value: 0,
                          focusColor: Colors.white,
                          activeColor: Colors.white,
                          hoverColor: Colors.white,
                        ),
                        tileColor: Color(0xff3C2F2F),
                        onTap: () => setState(() => _selectedMethod = 0),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        tileColor: const Color.fromARGB(255, 196, 191, 191),
                        subtitle: Text("3566 **** **** 0505"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: Image.asset(
                          "assets/splash/visa.png",
                          width: 60,
                        ),
                        title: Text(
                          "Debit card",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Radio(
                          value: 1,
                          activeColor: Colors.white,
                        ),
                        onTap: () => setState(() => _selectedMethod = 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "checkbox title".tr(),
                    style: TextStyle(fontSize: 14),
                  ),
                  activeColor: Colors.red,
                  value: ischecked,
                  onChanged: (value) {
                    setState(() {
                      ischecked = value!;
                    });
                  },
                ),
                Spacer(),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total".tr(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$ ${widget.totalPrice + 10.5 + 11.0}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                      onPressed: () {
                        context.read<CartCubit>().clearCart(widget.ordersId);
                      },
                      child: Text(
                        "Pay Now".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
