class AuthUser {
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? id;
  final String? token;
  final String? refreshToken;
  final String? profilePic;

  AuthUser({
     this.email,
     this.password,
    this.firstName,
    this.id,
    this.lastName,
    this.phoneNumber,
    this.token,
    this.refreshToken,
    this.profilePic
  });

   factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      email: json['result']['username'],
      id: json['result']['_id'],
      firstName: json['result']['firstname'],
      lastName: json['result']['lastname'],
      token: json['result']['token'],
      phoneNumber: json['result']['phone_no'],
      refreshToken: json['result']['refreshToken'],
      profilePic: json['result']['avatar'],
    );
  }
}


class UserWallet {
  final dynamic total;
  final dynamic transactions;
  final bool? status;
 
  UserWallet({
     this.total,
     this.transactions,
    this.status,
  });

   factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      total: json['result']['total'],
      transactions: json['result']['transactions'],
      status: json['result']['status'],
      
    );
  }
}
