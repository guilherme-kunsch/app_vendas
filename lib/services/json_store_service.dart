import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class JsonStorageService {
  /// Retorna o diretório local do app
  static Future<String> _getDirectoryPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  /// Retorna o arquivo de uma entidade (ex: 'usuarios')
  static Future<File> _getFile(String fileName) async {
    final path = await _getDirectoryPath();
    return File('$path/$fileName.json');
  }

  /// Lê os dados de um arquivo JSON
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

  /// Escreve dados em um arquivo JSON
  static Future<void> writeData(String fileName, List<dynamic> data) async {
    try {
      final file = await _getFile(fileName);
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Erro ao salvar arquivo $fileName: $e');
    }
  }
}
