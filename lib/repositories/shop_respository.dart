import 'package:tedza/data/network_service.dart';

class ShopRepository {
  ShopRepository();

  Future getAllShopProduct() {
    return NetworkService().getAllShopProduct();
  }

}
