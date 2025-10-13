class UserModel {
  String? userId;
  String? userLogin;
  String? userPass;
  String? usernom;
  String? userprenom;

  UserModel({this.userId, this.userLogin, this.userPass});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['UsrNo'];
    usernom = json['USRNOM'];
    userprenom = json['USRPRENOM'];
    userLogin = json['USRLOGIN'];
    userPass = json['UsrPassw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UsrNo'] = userId;
    data['USRNOM'] = usernom;
    data['USRPRENOM'] = userprenom;
    data['USRLOGIN'] = userLogin;
    data['UsrPassw'] = userPass;
    return data;
  }
}
