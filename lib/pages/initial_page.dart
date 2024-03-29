// ignore: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vsfirst/components/task.dart';
import 'package:vsfirst/data/task_dao.dart';
import 'package:vsfirst/pages/form_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final String photoLink = 'assets/images/default.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh))
            ],
            leading: Container(),
            title: const Text(
              'Flutter: Tarefas',
            )),
        body: Container(
          color: Colors.grey[300],
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 70, left: 8, right: 8),
            child: Container(

                // --Old usando TaskInherited:
                //child: ListView(
                //     padding:
                //         const EdgeInsets.only(top: 8, bottom: 70, left: 8, right: 8),
                //     children: TaskInherited.of(context)!.taskList),
                // ----------------------------------------------------
                //Agora usando o método de banco de dados:
                child: FutureBuilder<List<Task>>(
              future: TaskDao().onFindAll(),
              builder: (context, snapshot) {
                List<Task>? items = snapshot.data;
                //ListView.Builder controi os itens conforme são mostrados na tela
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ]),
                    );

                  case ConnectionState.waiting:
                    return Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        Text('Aguarde'),
                      ]),
                    );
                    break;
                  case ConnectionState.active:
                    return Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ]),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];
                            return tarefa;
                          },
                        );
                      }
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Icon(
                              Icons.error_outline,
                              size: 128,
                              color: Colors.grey.shade400,
                            ),
                            Text(
                              'Não há nenhuma Tarefa',
                              style: TextStyle(
                                  fontSize: 32, color: Colors.grey.shade500),
                            )
                          ]));
                    }
                    return const Text('Erro ao carregar tarefas');
                }
              },
            )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (newContext) => FormScreen(
                  taskContext: context,
                ),
              ),
            ).then((value) => setState(() {
                  log('Recarregando a tela inicial');
                }));
          },
          child: const Icon(Icons.add),
        ));
  }
}
