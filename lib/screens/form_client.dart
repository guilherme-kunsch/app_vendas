final _formKey = GlobalKey<FormState>();
final TextEditingController nomeController = TextEditingController();
final TextEditingController tipoController = TextEditingController();
final TextEditingController documentoController = TextEditingController();
// ... outros controladores opcionais

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: nomeController,
        decoration: InputDecoration(labelText: 'Nome *'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
      TextFormField(
        controller: tipoController,
        decoration: InputDecoration(labelText: 'Tipo (F/J) *'),
        validator: (value) {
          if (value == null || (value != 'F' && value != 'J')) {
            return 'Informe F ou J';
          }
          return null;
        },
      ),
      TextFormField(
        controller: documentoController,
        decoration: InputDecoration(labelText: 'Documento *'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Salvar cliente
          }
        },
        child: const Text('Salvar'),
      ),
    ],
  ),
)
