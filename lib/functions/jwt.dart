import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class JWTProvider extends ChangeNotifier {
  //flutter_secure_storage
  final storage = new FlutterSecureStorage();

  // Write value
  //Set Token
  void setToken(token, phone) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'phone', value: phone);
    notifyListeners();
  }
  void setName(name) async {
    await storage.write(key: 'name', value: name);
    notifyListeners();
  }

  //Remove Token
  Future<void> removeToken() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'phone');
    await storage.delete(key: 'name');
    notifyListeners();
  }

  //Phone State
  Future get phone async {
    return await storage.read(key: "phone");
  }

  //Token
  Future get token async {
    return await storage.read(key: "token");
  }

  Future get name async {
    return await storage.read(key: "name");
  }

  //Language
  //Set Token
  void changeLang(String language) async {
    await storage.write(key: 'language', value: language);
    notifyListeners();
  }

  //Language State
  Future get language async {
    return await storage.read(key: "language");
  }
}
