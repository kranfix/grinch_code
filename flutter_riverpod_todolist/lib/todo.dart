import 'package:meta/meta.dart';
import 'package:state_notifier/state_notifier.dart';

/// A read-only description of a todo-item
class Todo {
  Todo({
    @required this.id,
    @required this.text,
    this.done = false,
  })  : assert(id != null),
        assert(text != null),
        assert(done != null);

  Todo.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          text: map['text'],
          done: map['done'],
        );

  final String id;
  final String text;
  final bool done;

  @override
  String toString() {
    return 'Todo(text: $text, done: $done)';
  }

  static List<Todo> parseList(List list) {
    return [for (final map in list) Todo.fromMap(map)];
  }
}

/// An object that controls a list of [Todo].
class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo> initialTodos]) : super(initialTodos ?? []);

  void add(Todo todo) {
    assert(todo != null);
    state = [
      ...state,
      todo,
    ];
  }

  void updateOne(Todo target) {
    assert(target != null);
    state = [
      for (final todo in state)
        if (todo.id == target.id) target else todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
