import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'todo.dart';

/// Creates a [TodoList] and initialise it with pre-defined values.
///
/// We are using [StateNotifierProvider] here as a `List<Todo>` is a complex
/// object, with advanced business logic like how to edit a todo.
final todoListProvider = StateNotifierProvider(
  (ref) => TodoList([
    //Todo(id: 'todo-0', text: 'hi'),
    //Todo(id: 'todo-1', text: 'hello'),
    //Todo(id: 'todo-2', text: 'bonjour'),
  ]),
);

/// The different ways to filter the list of todos
enum TodoListFilter {
  all,
  active,
  completed,
}

/// The currently active filter.
///
/// We use [StateProvider] here as there is no fancy logic behind manipulating
/// the value since it's just enum.
final todoListFilter = StateProvider((_) => TodoListFilter.all);

/// The number of uncompleted todos
///
/// By using [Provider], this value is cached, making it performant.\
/// Even multiple widgets try to read the number of uncompleted todos,
/// the value will be computed only once (until the todo-list changes).
///
/// This will also optimise unneeded rebuilds if the todo-list changes, but the
/// number of uncompleted todos doesn't (such as when editing a todo).
final uncompletedTodosCount = Provider((ref) {
  final todos = ref.watch(todoListProvider.state);
  return todos.fold(0, (prev, todo) => prev + (todo.done ? 0 : 1));
});

/// The list of todos after applying of [todoListFilter].
///
/// This too uses [Provider], to avoid recomputing the filtered list unless either
/// the filter of or the todo-list updates.
final filteredTodos = Provider((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider.state);

  switch (filter.state) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.done).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.done).toList();
    case TodoListFilter.all:
    default:
      return todos;
  }
});
