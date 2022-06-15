import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  late String size;
  get isSize => size;

  int _quantity = 1;
  get quantity => _quantity;

  void changeSize(String newSize) {
    size = newSize;
    notifyListeners();
  }
  void getSize(String newSize) {
    size = newSize;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    _quantity--;
    notifyListeners();
  }
}