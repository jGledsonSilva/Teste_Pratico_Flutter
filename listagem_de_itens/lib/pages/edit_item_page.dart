import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listagem_de_itens/entities/item_entity.dart';
import 'package:listagem_de_itens/pages/var.dart';
import 'package:listagem_de_itens/services/sharedpreferences.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditItemPage extends StatefulWidget {
  final ItemEntity? entity;

  const EditItemPage({super.key, this.entity});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final imagePicker = ImagePicker();
  final title = TextEditingController();
  final description = TextEditingController();
  final image = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    if (widget.entity != null) {
      title.text = widget.entity!.title;
      description.text = widget.entity!.description;
      image.text = widget.entity!.image;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          image.text = pickedFile.path;
        });
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
  }

  int _generateId() {
    int max = 0;
    List<int> ids = [];
    if (task != null) {
      for (var i in task) {
        ids.add(i.id.toInt());
      }
      for (int i in ids) {
        if (i > max) {
          max = i;
        }
      }
      return max + 1;
    } else {
      return 0;
    }
  }

  Future<void> _saveItem() async {
    if (_validateFields()) {
      List<ItemEntity> currentTask = await SharedPreferencesService().getList();

      if (widget.entity == null) {
        currentTask.add(ItemEntity(
            id: _generateId(),
            title: title.text,
            image: image.text,
            description: description.text));
      } else {
        for (var item in currentTask) {
          if (item.id == widget.entity!.id) {
            item.title = title.text;
            item.image = image.text;
            item.description = description.text;
            break;
          }
        }
      }

      SharedPreferencesService().saveList(currentTask);
      Navigator.of(context).pop(true);
    } else {
      print('Todos os campos são obrigatórios');
    }
  }

  bool _validateFields() {
    return title.text.isNotEmpty &&
        image.text.isNotEmpty &&
        description.text.isNotEmpty;
  }

  void _clearFields() {
    title.clear();
    image.clear();
    description.clear();
  }

  void _cancel() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Lista de item',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildImagePicker(),
            const SizedBox(height: 32),
            _buildFormFields(),
            const SizedBox(height: 10),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 125,
              backgroundColor: Colors.blue[200],
              child: CircleAvatar(
                radius: 115,
                backgroundColor: Colors.blue[300],
                backgroundImage:
                    image.text.isNotEmpty ? FileImage(File(image.text)) : null,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.blue[200],
                child: IconButton(
                  onPressed: _showOpcoesBottomSheet,
                  icon: Icon(
                    PhosphorIcons.pencilSimple,
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: title,
            decoration: InputDecoration(
              hintText: 'Titulo do item',
              labelText: 'Titulo',
              prefixIcon: Icon(Icons.title),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: description,
            decoration: InputDecoration(
              hintText: 'Descrição do item',
              labelText: 'Descrição',
              prefixIcon: Icon(Icons.description),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: null,
            minLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            onPressed: _saveItem,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            onPressed: _clearFields,
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
            label: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: _cancel,
            icon: const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            label: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
              _buildBottomSheetOption(
                icon: PhosphorIcons.image,
                text: 'Galeria',
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              _buildBottomSheetOption(
                icon: PhosphorIcons.camera,
                text: 'Câmera',
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              _buildBottomSheetOption(
                icon: PhosphorIcons.trash,
                text: 'Remover',
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    image.clear();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Center(
          child: Icon(
            icon,
            color: Colors.grey[500],
          ),
        ),
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }
}
