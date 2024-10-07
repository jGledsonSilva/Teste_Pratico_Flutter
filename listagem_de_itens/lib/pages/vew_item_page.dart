import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listagem_de_itens/entities/item_entity.dart';
import 'package:listagem_de_itens/pages/var.dart';

class ViewItemPage extends StatefulWidget {
  final ItemEntity? entity;

  const ViewItemPage({super.key, this.entity});

  @override
  State<ViewItemPage> createState() => _ViewItemPage();
}

class _ViewItemPage extends State<ViewItemPage> {
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
              backgroundColor: Colors.grey[200],
              child: CircleAvatar(
                radius: 115,
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    image.text.isNotEmpty ? FileImage(File(image.text)) : null,
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
            // somente leitura
            readOnly: true,
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
            // somente leitura
            readOnly: true,
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
}
