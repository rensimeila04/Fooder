import 'package:flutter/cupertino.dart';
import 'package:fooder/models/menu_model.dart';
import 'package:fooder/services/menu_services.dart';

class MenuProvider with ChangeNotifier {
  List<MenuModel> _menus = [];
  List<MenuModel> get menus => _menus;
  set menus(List<MenuModel> menus) {
    _menus = menus;
    notifyListeners();
  }

  saveNotes(int id, String notes) {
    _menus[id - 1].catatan = notes;
    notifyListeners();
  }

  menuQuantity(int id) {
    _menus[id - 1].quantity = 0;
    notifyListeners();
  }

  addMenu(int id) {
    _menus[id - 1].quantity++;
    notifyListeners();
  }

  minMenu(int id) {
    _menus[id - 1].quantity--;
    notifyListeners();
  }

  deleteItem(){
    for(var item in _menus){
      item.quantity = 0;
    }
    notifyListeners();
  }

  deleteNotes(){
    for(var item in _menus){
      item.catatan = '';
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _menus) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _menus) {
      total += (item.quantity * item.harga);
    }

    return total;
  }

  Future<void> getMenu() async {
    try {
      List<MenuModel> menus = await MenuService().getMenu();
      _menus = menus;
    } catch (e) {
      print(e);
    }
  }
}
