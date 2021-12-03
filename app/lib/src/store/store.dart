import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' show ReadContext, SelectContext;

import 'store_state.dart';

typedef StoreSelector<T, R> = R? Function(T? value);

class Store {
  final BuildContext context;

  const Store(this.context);

  StoreState get state => context.read<StoreState>();

  T? read<T>([StoreWhere<T>? where]) => state.read<T>(where);

  void write<T>(T value, {StoreWhere<T>? where}) =>
      state.write(value, where: where);

  void upsert<T>(T Function(T?) update, {StoreWhere<T>? where}) => state.upsert(
        update,
        where: where,
      );

  void update<T>(T Function(T) update, {StoreWhere<T>? where}) => state.update(
        update,
        where: where,
      );

  void delete<T>([StoreWhere<T>? where]) => state.delete<T>(where);

  R? select<T, R>(StoreSelector<T, R> selector, {StoreWhere<T>? where}) =>
      context.select<StoreState, R?>(
        (StoreState state) => selector(state.read<T>(where)),
      );

  T? watch<T>([StoreWhere<T>? where]) => select<T, T>(
        (T? value) => value,
        where: where,
      );
}
