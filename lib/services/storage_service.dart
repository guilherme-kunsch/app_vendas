import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<List<dynamic>> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString);
      } catch (e) {
        print('Erro ao ler JSON: $e');
        return [];
      }
    }
    return [];
  }

  static Future<void> writeData(String key, List<dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final jsonString = jsonEncode(data);
      await prefs.setString(key, jsonString);
    } catch (e) {
      print('Erro ao salvar JSON: $e');
    }
  }
}
