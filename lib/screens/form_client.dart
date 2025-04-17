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

  final _formKey = GlobalKey<FormState>();

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
    if (_formKey.currentState!.validate()) {
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
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    TextInputType? teclado,
    bool obrigatorio = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: teclado,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF0F1F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator:
            obrigatorio
                ? (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Campo obrigatório'
                        : null
                : null,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _input(
                label: 'Nome *',
                controller: nomeController,
                obrigatorio: true,
              ),
              _input(
                label: 'Tipo (F ou J) *',
                controller: tipoController,
                obrigatorio: true,
              ),
              _input(
                label: 'Documento *',
                controller: documentoController,
                obrigatorio: true,
              ),
              _input(label: 'Email', controller: emailController),
              _input(label: 'Telefone', controller: telefoneController),
              _input(label: 'CEP', controller: cepController),
              _input(label: 'Endereço', controller: enderecoController),
              _input(label: 'Bairro', controller: bairroController),
              _input(label: 'Cidade', controller: cidadeController),
              _input(label: 'UF', controller: ufController),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
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
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
