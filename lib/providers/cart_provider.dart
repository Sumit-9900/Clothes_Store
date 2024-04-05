import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Map<int, int> _cartproduct = {};

  Map<int, ClothesModel> _productsMap = {};

  Map<int, int> get cartproduct => _cartproduct;

  void addProductToCart(
      BuildContext context, int productId, ClothesModel product) {
    if (!_cartproduct.containsKey(productId)) {
      _cartproduct[productId] = 1;
      _productsMap[productId] = product;
    } else {
      _cartproduct[productId] = _cartproduct[productId]! + 1;
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product Added to Cart!'),
      ),
    );
    notifyListeners();
  }

  void removeProductFromCart(
      int productId, BuildContext context, ClothesModel product) {
    if (_cartproduct.containsKey(productId)) {
      if (_cartproduct[productId] == 1) {
        _cartproduct.remove(productId);
        _productsMap.remove(product);
      } else {
        _cartproduct[productId] = _cartproduct[productId]! - 1;
      }
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item deleted from Cart!'),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            addProductToCart(context, productId, product);
          },
        ),
      ),
    );
    notifyListeners();
  }

  ClothesModel? getProductById(int id) {
    return _productsMap[id];
  }
}
