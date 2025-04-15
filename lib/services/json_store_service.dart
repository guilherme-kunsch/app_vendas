import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class JsonStorageService {
  static Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File> _getFile(String fileName) async {
    final path = await _getDirectoryPath();
    return File('$path/$fileName.json');
  }

  static Future<List<dynamic>> readData(String fileName) async {
    try {
      final file = await _getFile(fileName);
      if (await file.exists()) {
        final content = await file.readAsString();
        return jsonDecode(content);
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao ler arquivo $fileName: $e');
      return [];
    }
  }

  static Future<void> writeData(String fileName, List<dynamic> data) async {
    try {
      final file = await _getFile(fileName);
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Erro ao salvar arquivo $fileName: $e');
    }
  }
}
