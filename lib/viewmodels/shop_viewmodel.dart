import 'package:flutter/material.dart';
import 'package:tedza/models/product_model.dart';
import 'package:tedza/repositories/shop_respository.dart';
import 'package:tedza/utilities/snackbar_utils.dart';

class ShopViewModel extends ChangeNotifier {
  String? _price = "";
  String? get price => _price;
  String _searchText = "";

  List<PPProductModel> _productList = [];
  final List<PPProductModel> _favouriteList = [];
  final List<PPProductModel> _filteredList = [];
  ShopRepository shopRepository = ShopRepository();
  bool _loading = false;
  bool _error = false;
  bool _isSearching = false;
  bool get error => _error;

  bool get isSearching => _isSearching;
  List<PPProductModel> get productList => _productList;
  List<PPProductModel> get filteredList => _filteredList;
  List<PPProductModel> get favouriteList => _favouriteList;
  bool get loading => _loading;
  String get searchText => _searchText;

  // CheckOutRepository checkOutRepository = CheckOutRepository();

  setLoading(bool loading, bool error) async {
    _error = error;
    _loading = loading;
    notifyListeners();
  }

  void searchListState(String searchQuery) {
    if (searchQuery.isEmpty) {
      _isSearching = false;
      _searchText = "";
      _buildSearchList();
    } else {
      _isSearching = true;
      _searchText = searchQuery;
      _buildSearchList();
    }
    notifyListeners();
  }

  List<PPProductModel> _buildSearchList() {
    if (_filteredList.isEmpty || _searchText == "") {
      return _productList = _filteredList;
    } else {
      _productList = _productList
          .where((prodduct) => prodduct.productName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
      return _productList;
    }
  }

  void clearSearchField() {
    _searchText = "";
    searchListState(_searchText);
    // _buildSearchList();
    notifyListeners();
  }

  addToCart(String id) async {
    final response = await shopRepository.addToCart(id);
    return response;
  }

  removeFromCart(id) async {
    // print(id);
    final response = await shopRepository.removeFromCart(id);
    //  notifyListeners();
    return response;
  }

 

  addToFavourite(PPProductModel product) {
    if (!_favouriteList.any((element) => element.id == product.id)) {
      _favouriteList.add(product);
    } else {
      removeFromFavorite(product);
    }

    notifyListeners();
  }

  removeFromFavorite(PPProductModel product) {
    _favouriteList.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  checkFavourite(PPProductModel product) {
    // print(favouriteList.length);
    // var favouriteItem = _favouriteList.where((element) => element.id == product.id);
    if (_favouriteList.any((element) => element.id == product.id)) {
      //notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future getAllShopProduct() async {
    setLoading(true, true);
    final response = await shopRepository.getAllShopProduct();
    if (response != false) {
      setLoading(false, false);
      List<PPProductModel> allProductList = [];
      for (var item in response) {
        PPProductModel ppProductModel = PPProductModel.fromJson(item);
        allProductList.add(ppProductModel);
        filteredList.add(ppProductModel);
        _productList = allProductList;
      }
    } else {
      setLoading(false, true);
    }

    notifyListeners();
    return response;
  }

  // Future getCartProduct() async {
  //   // setLoading(true);
  //   final response = await shopRepository.getCartProduct();
  //   if (response != false) {
  //     List<PPCartProductModel> allCartList = [];
  //     _cartList.clear();
  //     for (var item in response['result']) {
  //       PPCartProductModel ppProductModel = PPCartProductModel.fromJson(item);
  //       allCartList.add(ppProductModel);
  //       _cartList = allCartList;
  //     }
  //   }
  //   // setLoading(false);
  //   notifyListeners();
  //   return response;
  // } 

   void showError(String message) {
    PPSnackBarUtilities().showSnackBar(
      message: message,
      snackbarType: SNACKBARTYPE.error,
    );
  }

 

  // bool get isFavourite{
  //   return checkFavourite(product)
  // }
}
