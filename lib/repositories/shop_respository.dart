import 'package:tedza/data/network_service.dart';

class ShopRepository {
  ShopRepository();

  Future getAllShopProduct() {
    return NetworkService().getAllShopProduct();
  }

  Future getCartProduct() {
    return NetworkService().getCartProduct();
  }
  
  Future getAllOrders() {
    return NetworkService().getAllOrders();
  }

  Future getDeliveryStates() {
    return NetworkService().getDeliveryStates();
  }

  Future addToCart(
    String productID,
  ) {
    return NetworkService().addToCart(
      productID,
    );
  }

  Future removeFromCart(String productID) {
    return NetworkService().removeFromCart(productID);
  }

  Future dopFromCart(String productID) {
    return NetworkService().dropFromCart(productID);
  }
}
