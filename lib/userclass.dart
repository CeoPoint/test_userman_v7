List<Users> users = [];
List<Users> usernonactive = [];
List<UserOnline> useronline = [];
List<UserOffline> userofflinesession = [];
List<UserOffline> useroffline = [];
List<UserOffline> userofflineReal = [];
String? ipAddress, username, password;

class Users {
  final String? name;
  Users({
    required this.name,
  });
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
    );
  }
}

//clas user online
class UserOnline {
  final String? name;
  UserOnline({
    required this.name,
  });
  factory UserOnline.fromJson(Map<String, dynamic> json) {
    return UserOnline(
      name: json['user'],
    );
  }
}

//class user offline
class UserOffline {
  final String? name;
  UserOffline({
    required this.name,
  });
  factory UserOffline.fromJson(Map<String, dynamic> json) {
    return UserOffline(
      name: json['user'],
    );
  }
}

//mikrotik
class Endpoints {
  String ip = '';
  Endpoints(this.ip);
  // Get All User
  String get allUser => "http://$ip/rest/user-manager/user?.proplist=name";
  // Get User Online
  String get onlineUser =>
      "http://$ipAddress/rest/user-manager/session?.proplist=user&active=true";
  // Get User Online Compare
  String get getOfflineUser =>
      "http://$ipAddress/rest/user-manager/session?.proplist=user,user-address,nas-port-id,calling-station-id,ended&active=false";
  //get Seesion
  static final getSession = "http://$ipAddress/rest/user-manager/session?";
}
