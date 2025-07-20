import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testing/userclass.dart';

  Endpoints endpoints = Endpoints(ipAddress!);
//get users

getUsers() async {
  final response = await http.get(
    Uri.parse(endpoints.allUser),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}'
    },
  );
  if (response.statusCode == 200) {
    users.clear();
    var data = jsonDecode(response.body);
    data.forEach((e) {
      users.add(Users.fromJson(e));
    });
    for (var i in users) {
      usernonactive.add(i);
    }
   }
}

//get user Online
getUserOnline() async {
  final response = await http.get(
    Uri.parse(endpoints.onlineUser),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}'
    },
  );
  if (response.statusCode == 200) {
    useronline.clear();
    var data = jsonDecode(response.body);
    data.forEach((e) {
      useronline.add(UserOnline.fromJson(e));
    });
  }
}


//get useroffline
getUserOffline() async {
  final response = await http.get(
    Uri.parse(endpoints.getOfflineUser),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}'
    },
  );
//response berhasil
  if (response.statusCode == 200) {
    //clear data
    userofflinesession.clear();
    useroffline.clear();
    userofflineReal.clear();
    var data = jsonDecode(response.body);
    //tambah data useroffsesion
    data.forEach((e) {
      userofflinesession.add(UserOffline.fromJson(e));
    });
    //hapus duplikat sama dengan online
    userofflinesession.removeWhere((element) =>
        useronline.any((element2) => element.name == element2.name));
    //remove duplikat di usersession re
    List<UserOffline> userRM = rmDuplicate(userofflinesession);
    //remove usernonactive = user - user online
    usernonactive.removeWhere((element) =>
        useronline.any((element2) => element.name == element2.name));
    //tambah variable kosong
    for (var i in usernonactive) {
      userRM.add((UserOffline(
          name: i.name,)));
    }
    useroffline = rmDuplicate(userRM);
    for (var i in users) {
      for (var u in useroffline) {
        if (i.name == u.name) {
          userofflineReal.add(UserOffline(
              name: u.name,));
        }
      }
    }
  }
}

//remove duplikat
rmDuplicate(List<UserOffline> user) {
  final List<UserOffline> unique = [];
  Set<String?> uniqueName = <String>{};

  for (UserOffline item in user) {
    if (!uniqueName.contains(item.name)) {
      unique.add(item);
      uniqueName.add(item.name);
    }
  }

  return unique;
}