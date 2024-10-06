import 'dart:io';

import 'package:flutter/material.dart';
import 'package:listagem_de_itens/pages/edit_item_page.dart';
import 'package:listagem_de_itens/pages/var.dart';
import 'package:listagem_de_itens/services/sharedpreferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    populateList();
  }

  populateList() async {
    task = await SharedPreferencesService().getList();
    setState(() {
      loaded = true;
    });
  }

  void deleteTask(int id) {
    setState(() {
      task.removeWhere((item) => item.id == id);
    });
    SharedPreferencesService().saveList(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: loaded,
              replacement: Center(child: CircularProgressIndicator()),
              child: Expanded(
                child: ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: Key(task[index].id.toString()),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            deleteTask(task[index].id);
                          },
                        ),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              deleteTask(task[index].id);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) async {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditItemPage(
                                    entity: task[index],
                                  ),
                                ),
                              );
                              if (result == true) {
                                populateList();
                              }
                            },
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 10,
                        color: Colors.blue,
                        margin: EdgeInsets.all(5),
                        child: Container(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (task[index].image.isNotEmpty)
                                CircleAvatar(
                                  backgroundImage:
                                      FileImage(File(task[index].image)),
                                  radius: 50,
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${task[index].title}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    '${task[index].description}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditItemPage(),
            ),
          );
          if (result == true) {
            populateList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}