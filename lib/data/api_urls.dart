class APIBase {

  static String get developmentURL {
    return 'https://api.escuelajs.co/api/v1';
  }
}

class APIPathHelper {
  APIPathHelper();

  //Auth

  String submitPasswordForForgotPassword =
      '${APIBase.developmentURL}/auth/forgot-password';
  String validateUserEmailForForgotPassword =
      '${APIBase.developmentURL}/auth/verify-email';
  String submitOtpForForgotPassword =
      '${APIBase.developmentURL}/auth/verify-otp';
  String signUpUser = '${APIBase.developmentURL}/users';
  String userSignInUrl = '${APIBase.developmentURL}/auth/login';
  String getCurrentUser = '${APIBase.developmentURL}/user/get';
  String getUserWalletBalance = '${APIBase.developmentURL}/transaction/perrypoint/get';
  String updateUser = '${APIBase.developmentURL}/user/update';
  String logoutUrl = '${APIBase.developmentURL}/auth/logout';
  String deleteUrl = '${APIBase.developmentURL}/user/remove';
  String changePassword = 'https://perrypay.vercel.app/auth/change-password';

  //Shop
  String getAllShopProduct = '${APIBase.developmentURL}/products';
  String addToCart = '${APIBase.developmentURL}/cart/add';
  String removeFromCart = '${APIBase.developmentURL}/cart/remove';
  String dropFromCart = '${APIBase.developmentURL}/cart/drop';
  String getCartProduct = '${APIBase.developmentURL}/cart/get';
  String getAllOrders = '${APIBase.developmentURL}/order/get/all';
  String getDelivery = 'https://perrypay.vercel.app/store/delivery-state/get';
  String payPerryPoint = '${APIBase.developmentURL}/transaction/perrypoint/pay';
  String createOrder = '${APIBase.developmentURL}/order/add';

}
