import '../models/usuario.dart';
import '../services/json_store_service.dart';
import 'package:uuid/uuid.dart';

class UsuarioController {
  List<Usuario> usuarios = [];

  final String _arquivo = 'usuarios';

  Future<void> carregarUsuarios() async {
    final data = await JsonStorageService.readData(_arquivo);
    usuarios = data.map((e) => Usuario.fromJson(e)).toList();
  }

  Future<void> salvarUsuarios() async {
    final data = usuarios.map((u) => u.toJson()).toList();
    await JsonStorageService.writeData(_arquivo, data);
  }

  Future<void> adicionarUsuario(String nome, String senha) async {
    final novoUsuario = Usuario(
      id: const Uuid().v4(),
      nome: nome,
      senha: senha,
    );
    usuarios.add(novoUsuario);
    await salvarUsuarios();
  }

  Future<void> atualizarUsuario(Usuario usuarioAtualizado) async {
    final index = usuarios.indexWhere((u) => u.id == usuarioAtualizado.id);
    if (index != -1) {
      usuarios[index] = usuarioAtualizado;
      await salvarUsuarios();
    }
  }

  Future<void> removerUsuario(String id) async {
    usuarios.removeWhere((u) => u.id == id);
    await salvarUsuarios();
  }

  Usuario? validarLogin(String nome, String senha) {
    try {
      return usuarios.firstWhere((u) => u.nome == nome && u.senha == senha);
    } catch (e) {
      return null;
    }
  }
}
