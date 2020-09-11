import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoRepoProvider = Provider((ref) => TodoRepo(ref.read));

class TodoRepo {
  static const _url = 'http://192.168.0.11:8080/graphql';

  const TodoRepo(this.read) : assert(read != null, 'ref must be non-null');

  final Reader read;
}
