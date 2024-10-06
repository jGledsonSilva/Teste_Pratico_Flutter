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
    if (widget.entity != null) {
      title.text = widget.entity!.title;
      description.text = widget.entity!.description;
      image.text = widget.entity!.image;
    }
  }

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image.text = pickedFile.path;
      });
    }
  }

  getid() {
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

  void _saveItem() async {
    if (title.text != '' && image.text != '' && description.text != '') {
      // Carregar a lista de itens do SharedPreferences
      List<ItemEntity> currentTask = await SharedPreferencesService().getList();

      if (widget.entity == null) {
        // Adicionar novo item à lista
        currentTask.add(ItemEntity(
            id: getid(),
            title: title.text,
            image: image.text,
            description: description.text));
      } else {
        // Atualizar item existente
        widget.entity!.title = title.text;
        widget.entity!.image = image.text;
        widget.entity!.description = description.text;
      }

      // Salvar a lista atualizada no SharedPreferences
      SharedPreferencesService().saveList(currentTask);
      Navigator.of(context).pop(true);
    } else {
      print('Todos os campos são obrigatórios');
    }
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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          )),
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
                          radius: 125,
                          backgroundColor: Colors.grey[200],
                          child: CircleAvatar(
                            radius: 115,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: image.text != ''
                                ? FileImage(File(image.text))
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
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
                Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
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
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: description,
                          decoration: InputDecoration(
                              hintText: 'Descrição do item',
                              labelText: 'Descrição',
                              prefixIcon: Icon(Icons.description),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.blue)),
                                  onPressed: _saveItem,
                                  icon: const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.blue)),
                                  onPressed: _clearFields,
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Clear',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(Colors.red)),
                                  onPressed: _cancel,
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            )));
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
}
