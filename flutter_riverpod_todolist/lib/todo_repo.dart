import 'dart:convert';
import './todo_list_provider.dart';
import './todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final todoRepoProvider = Provider((ref) => TodoRepo(ref.read));

class TodoRepo {
  static const _url = 'http://192.168.0.11:8080/graphql';

  const TodoRepo(this.read) : assert(read != null, 'ref must be non-null');

  final Reader read;

  Future<void> findAll() async {
    final response = await http.get('$_url?query={todoList{id,text,done}}');
    final result = json.decode(response.body) as Map<String, dynamic>;
    if (result['errors'] != null) {
      print(result['errors']);
      throw Exception('Error reading all todos');
    }
    final todoList = read(todoListProvider);
    todoList.addAll(Todo.parseList(result['data']['todoList']));
  }

  Future<Todo> findOne(String id) async {
    assert(id != null);
    final response =
        await http.get('$_url?query={todo(id:"$id"){id,text,done}}');
    final result = json.decode(response.body) as Map<String, dynamic>;
    if (result['errors'] != null) {
      print(result['errors']);
      throw Exception('Todo(id: "$id") can not be read');
    }
    return Todo.fromMap(result['data']['todo']);
  }

  Future<void> createOne(String text) async {
    assert(text != null);
    final response = await http.get(
      '$_url?query=mutation+_{createTodo(text:"$text"){id,text,done}}',
    );
    final result = json.decode(response.body) as Map<String, dynamic>;
    if (result['errors'] != null) {
      throw Exception('Todo(text: "$text") could not be created');
    }
    final newTodo = Todo.fromMap(result['data']['createTodo']);
    final todoList = read(todoListProvider);
    todoList.add(newTodo);
  }
}
