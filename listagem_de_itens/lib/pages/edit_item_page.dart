import 'package:flutter/material.dart';
import 'package:listagem_de_itens/adapters/item_adapter.dart';
import 'package:listagem_de_itens/atoms/item_atom.dart';
import 'package:listagem_de_itens/entities/item_entity.dart';
import 'package:listagem_de_itens/states/edit_item.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/text_input.dart';

import '../dtos/iten_dto.dart';

class EditItemPage extends StatefulWidget {
  final ItemEntity? entity;
  const EditItemPage({
    super.key,
    this.entity,
  });

  @override
  State<EditItemPage> createState() => _EditIntemPageState();
}

class _EditIntemPageState extends State<EditItemPage> {
  late ItemDto dto;

  final imagePicker = ImagePicker();
  File? imageFile;

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  bool get editable => widget.entity != null;

  @override
  void initState() {
    super.initState();
    if (widget.entity != null) {
      dto = ItemAdapter.entityToDTO(widget.entity!);
    } else {
      dto = ItemDto(image: '', title: '', description: '');
    }
    edititemState.value = const StartEditItemState();
    edititemState.addListener(_listener);
  }

  _listener() {
    setState(() {});
    return switch (edititemState.value) {
      StartEditItemState state => state,
      SavedItemState _ => Navigator.of(context).pop(),
      LoadingEditItemState state => state,
      FailureEditItemState state => _showSnackError(state),
    };
  }

  @override
  void dispose() {
    edititemState.removeListener(_listener);
    super.dispose();
  }

  void _showSnackError(FailureEditItemState state) {
    final snackBar = SnackBar(
      content: Text(
        state.message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _save() {
    if (!dto.isValid()) {
      _showSnackError(const FailureEditItemState('Campos inválidos'));
      return;
    }

    if (editable) {
      updateItemAction.value = dto.copy();
    } else {
      createItemAction.value = dto.copy();
    }
  }

  void _clear() {
    setState(
        () => dto = ItemDto(id: dto.id, title: '', image: '', description: ''));
  }

  @override
  Widget build(BuildContext context) {
    final state = edititemState.value;

    final enabled = state is! LoadingEditItemState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit intem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey[200],
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: _showOpcoesBottomSheet,
                          icon: Icon(
                            PhosphorIcons.pencilSimple,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            TextInput(
              key: Key('title:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.title,
              hint: 'Titulo',
              validator: dto.titleValidate,
              onChanged: (value) => dto.title = value,
            ),
            const SizedBox(height: 5),
            TextInput(
              key: Key('description:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.description,
              hint: 'Descrição', 
              validator: dto.descricaoValidate,
              onChanged: (value) => dto.description = value,
            ),
            const SizedBox(height: 5),
            TextInput(
              key: Key('details:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.image,
              hint: 'Detalhes',
              onChanged: (value) => dto.image = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                  onPressed: !enabled ? null : _save,
                  child: const Text('Salvar'),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: !enabled ? null : _clear,
                  child: const Text('Limpa'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.image,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.camera,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.trash,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tornar a foto null
                  setState(() {
                    imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
