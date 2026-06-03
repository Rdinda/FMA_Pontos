import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../services/sync_repository.dart';
import 'snackbar_utils.dart';

/// Exibe o diálogo para criar uma nova categoria.
Future<void> showAddCategoryDialog(BuildContext context) async {
  final nameController = TextEditingController();
  final codeController = TextEditingController();

  nameController.addListener(() {
    if (codeController.text.isEmpty) {
      final text = nameController.text.trim();
      if (text.isNotEmpty) {
        final len = text.length >= 2 ? 2 : text.length;
        codeController.text = text.substring(0, len).toUpperCase();
      }
    }
  });

  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Nova Categoria'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nome', filled: true),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: codeController,
            decoration: const InputDecoration(
              labelText: 'Código (Prefixo)',
              filled: true,
              helperText: 'Ex: OX para Oxum (Único)',
            ),
            textCapitalization: TextCapitalization.characters,
            maxLength: 4,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                codeController.text.isNotEmpty) {
              final newCat = Category(
                id: const Uuid().v4(),
                name: nameController.text.trim(),
                code: codeController.text.trim().toUpperCase(),
                updatedAt: DateTime.now(),
              );
              Provider.of<SyncRepository>(
                context,
                listen: false,
              ).addCategory(newCat);
              Navigator.pop(ctx);
            } else {
              SnackbarUtils.show(
                context,
                message: 'Preencha nome e código',
                isError: true,
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}
