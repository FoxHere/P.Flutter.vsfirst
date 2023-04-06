import 'package:flutter/material.dart';
import 'package:vsfirst/components/task.dart';
import 'package:vsfirst/data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});
  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova tarefa'),
        ),
        body: Container(
          color: Colors.grey[300],
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                  height: 550,
                  width: 320,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: nameController,
                          validator: (String? value) {
                            if (valueValidator(value)) {
                              return 'Insira o nome da tarefa';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.note_alt_outlined),
                            hintText: 'Nome da tarefa *',
                            fillColor: Colors.white70,
                            filled: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: difficultyController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                int.parse(value) > 5 ||
                                int.parse(value) < 1) {
                              return 'Insira uma dificauldade entre 1 e 5';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.auto_graph_sharp),
                            hintText: 'Dificuldade',
                            fillColor: Colors.white70,
                            filled: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.url,
                          validator: (value) {
                            if (valueValidator(value)) {
                              return 'Insira uma URL válida';
                            }
                            return null;
                          },
                          controller: imageController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.image),
                            hintText: 'Imagem *',
                            fillColor: Colors.white70,
                            filled: false,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 72,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageController.text,
                              errorBuilder: (
                                BuildContext context,
                                Object exception,
                                StackTrace? stacktrace,
                              ) {
                                return Image.asset('assets/images/nophoto.png');
                              },
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await TaskDao().onSave(Task(
                                      nameController.text,
                                      imageController.text,
                                      int.parse(difficultyController.text),
                                    ));
                                    // --Old Task inherited usage
                                    // TaskInherited.of(widget.taskContext)!.newTask(
                                    //     nameController.text,
                                    //     imageController.text,
                                    //     int.parse(difficultyController.text));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Nova tarefa inserida')));
                                    Navigator.pop(context);
                                  }
                                },
                                style: const ButtonStyle(),
                                child: const Text('Enviar',
                                    style: TextStyle(fontSize: 18))),
                          ),
                        ),
                      ))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
