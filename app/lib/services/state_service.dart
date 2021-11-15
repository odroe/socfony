import 'package:flutter/foundation.dart';

class StateService with ChangeNotifier {
  final List<dynamic> _state = [];

  Iterable<T> where<T>(bool Function(T element) fn) =>
      _state.whereType<T>().where(fn);

  T? find<T>(bool Function(T element) fn) {
    final result = where<T>(fn);

    return result.isNotEmpty ? result.first : null;
  }

  void add<T>(T element) {
    if (_state.contains(element)) {
      return;
    }

    _state.add(element);
    notifyListeners();
  }

  void remove<T>(bool Function(T element) fn) {
    final result = where<T>(fn);
    if (result.isNotEmpty) {
      _state.removeWhere((element) => result.contains(element));
      notifyListeners();
    }
  }

  void update<T>(T element, bool Function(T element) fn) {
    final result = where<T>(fn);
    if (result.isNotEmpty) {
      _state.removeWhere((element) => result.contains(element));
    }

    add<T>(element);
  }
}
