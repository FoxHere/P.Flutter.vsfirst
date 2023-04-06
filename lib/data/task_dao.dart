import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:vsfirst/components/task.dart';
import 'package:vsfirst/data/database.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT);';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  onSave(Task tarefa) async {
    log('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();

    var itemExists = await onFind(tarefa.name);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      return await bancoDeDados.insert(_tableName, taskMap);
    } else {
      log('A tarefa já existia');
      return await bancoDeDados.update(
        _tableName,
        taskMap,
        where: '$_name = ? ',
        whereArgs: [tarefa.name],
      );
    }
  }

  onDelete(String nomeDaTarefa) async {
    log('Deletando a terafa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tableName,
      where: '$_name = ? ',
      whereArgs: [nomeDaTarefa],
    );
  }

  Future<List<Task>> onFind(String nomeDaTarefa) async {
    log('Acessando o find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tableName, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
    log('Tarefa encontrda: ${toList(result)}');
    return toList(result);
  }

  Future<List<Task>> onFindAll() async {
    log('Acessando o nosso findAll: ');
    final Database bancoDeDados = await getDatabase();

    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    log('Dados encontrados: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    log('Convertendo to List: ');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    log('Retornando a lista de tarefas: $tarefas');
    return tarefas;
  }

  Map<String, dynamic> toMap(Task tarefa) {
    log('Convertendo tarefa em Map:');
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.name;
    mapaDeTarefas[_difficulty] = tarefa.difficult;
    mapaDeTarefas[_image] = tarefa.photo;
    log('Mapa de tarefas convertido: $mapaDeTarefas');
    return mapaDeTarefas;
  }
}
