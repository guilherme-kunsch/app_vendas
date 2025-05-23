import 'package:flutter/material.dart';
import '../controllers/cliente_controller.dart';
import '../models/cliente.dart';

class CadastroClienteScreen extends StatefulWidget {
  final Cliente? cliente;
  final int? index;

  const CadastroClienteScreen({super.key, this.cliente, this.index});

  @override
  State<CadastroClienteScreen> createState() => _CadastroClienteScreenState();
}

class _CadastroClienteScreenState extends State<CadastroClienteScreen> {
  final controller = ClienteController();

  final nomeController = TextEditingController();
  final tipoController = TextEditingController();
  final documentoController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final cepController = TextEditingController();
  final enderecoController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final ufController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      nomeController.text = widget.cliente!.nome;
      tipoController.text = widget.cliente!.tipo;
      documentoController.text = widget.cliente!.documento;
      emailController.text = widget.cliente!.email ?? '';
      telefoneController.text = widget.cliente!.telefone ?? '';
      cepController.text = widget.cliente!.cep ?? '';
      enderecoController.text = widget.cliente!.endereco ?? '';
      bairroController.text = widget.cliente!.bairro ?? '';
      cidadeController.text = widget.cliente!.cidade ?? '';
      ufController.text = widget.cliente!.uf ?? '';
    }
    controller.loadClientes();
  }

  void salvar() async {
    final cliente = Cliente(
      id: widget.cliente?.id ?? 0,
      nome: nomeController.text,
      tipo: tipoController.text,
      documento: documentoController.text,
      email: emailController.text,
      telefone: telefoneController.text,
      cep: cepController.text,
      endereco: enderecoController.text,
      bairro: bairroController.text,
      cidade: cidadeController.text,
      uf: ufController.text,
    );

    if (widget.index != null) {
      controller.atualizarCliente(widget.index!, cliente);
    } else {
      controller.adicionarCliente(cliente);
    }

    await controller.salvarClientes();
    if (context.mounted) Navigator.pop(context, true);
  }

  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF0F1F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.cliente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Cliente' : 'Cadastrar Cliente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _input('Nome', nomeController),
            _input('Tipo (F ou J)', tipoController),
            _input('Documento', documentoController),
            _input('Email', emailController),
            _input('Telefone', telefoneController),
            _input('CEP', cepController),
            _input('Endereço', enderecoController),
            _input('Bairro', bairroController),
            _input('Cidade', cidadeController),
            _input('UF', ufController),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC3002),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEdit ? 'Atualizar Cliente' : 'Salvar Cliente',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDC3002)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
