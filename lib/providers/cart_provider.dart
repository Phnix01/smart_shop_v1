import 'package:flutter/material.dart';
import 'package:smart_shop_v1/models/cart_model.dart';
import 'package:smart_shop_v1/providers/products_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductTOCart({required String productId}) {
    getCartItems.putIfAbsent(
      productId,
      () => CartModel(CartId: Uuid().v4(), productId: productId, quantity: 1),
    );
    notifyListeners();
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  double getTotal({required ProductsProvider productsProvider}) {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final getCurrentProduct = productsProvider.findByProdId(value.productId);
      if (getCurrentProduct == null) {
        total += 0.0;
      } else {
        total +=
            double.parse(getCurrentProduct.productDescription) * value.quantity;
      }
    });
    return total;
  }
}
