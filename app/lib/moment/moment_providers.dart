import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

/// Moment list provider.
final StateProvider<List<Moment>> momentsProvider =
    StateProvider<List<Moment>>((Ref ref) => <Moment>[]);

/// Create moment provider by moment id.
final ProviderFamily<Moment?, String> createMomentProvider =
    Provider.family<Moment?, String>((Ref ref, String id) {
  return ref.watch<Moment?>(
    momentsProvider.select<Moment?>((List<Moment> moments) {
      final Iterable<Moment> filtedMoments =
          moments.where((element) => element.id == id);
      if (filtedMoments.isNotEmpty) {
        return filtedMoments.first;
      }
    }),
  );
});

/// Extension for moment provider.
extension MomentExtension on Moment {
  /// Save moment.
  ///
  /// If moment already exists, update it.
  void save(Reader reader) {
    final int index =
        reader(momentsProvider).indexWhere((element) => element.id == id);
    if (index == -1) {
      reader(momentsProvider.state).update((state) => state..add(this));
      return;
    }

    reader(momentsProvider.state).update((state) {
      return state.map((element) {
        if (element.id == id) {
          return Moment()
            ..mergeFromMessage(element)
            ..mergeFromMessage(this);
        }

        return element;
      }).toList();
    });
  }
}
