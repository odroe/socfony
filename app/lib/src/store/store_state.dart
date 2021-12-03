import 'package:flutter/foundation.dart' show ChangeNotifier;

typedef StoreWhere<T> = bool Function(T value);

class StoreState with ChangeNotifier {
  static final StoreState _singleton = StoreState._internal();

  factory StoreState() => _singleton;

  StoreState._internal();

  final List<dynamic> items = [];

  Iterable<T> where<T>([StoreWhere<T>? where]) {
    final Iterable<T> result = items.whereType<T>();

    if (where == null) {
      return result;
    }

    return result.where(where);
  }

  T? read<T>([StoreWhere<T>? where]) {
    final Iterable<T> result = this.where<T>(where);

    return result.isEmpty
        ? null
        : where == null
            ? result.single
            : result.first;
  }

  void write<T>(T value, {StoreWhere<T>? where}) {
    final Iterable<T> result = this.where<T>(where);

    if (result.isNotEmpty) {
      items.removeWhere((item) => result.contains(item));
    }

    items.add(value);

    notifyListeners();
  }

  void upsert<T>(T Function(T?) update, {StoreWhere<T>? where}) {
    write(update(read<T>(where)), where: where);
  }

  void update<T>(T Function(T) update, {StoreWhere<T>? where}) {
    final T? item = read<T>(where);

    if (item is T) {
      write(update(item), where: where);
    }
  }

  void delete<T>([StoreWhere<T>? where]) {
    final Iterable<T> result = this.where<T>(where);

    if (result.isNotEmpty) {
      items.removeWhere((item) => result.contains(item));
    }

    notifyListeners();
  }
}
