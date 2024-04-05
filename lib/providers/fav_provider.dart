import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<int> _favoriteproductIds = [];

  List<int> get favoriteproductIds => _favoriteproductIds;

  List<ClothesModel> favoriteproducts(List<ClothesModel>? fetch) {
    List<ClothesModel> _favoriteproducts = [];
    for (int i = 0; i < favoriteproductIds.length; i++) {
      int productId = favoriteproductIds[i];
      for (int j = 0; j < fetch!.length; j++) {
        ClothesModel product = fetch[j];
        if (product.id == productId) {
          _favoriteproducts.add(product);
          break;
        }
      }
    }
    return _favoriteproducts;
  }

  void toggleFav(int id, BuildContext context) {
    if (_favoriteproductIds.contains(id)) {
      _favoriteproductIds.remove(id);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product removed from Favorites'),
        ),
      );
    } else {
      _favoriteproductIds.add(id);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product marked as Favorites'),
        ),
      );
    }
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favoriteproductIds.contains(id);
  }
}
