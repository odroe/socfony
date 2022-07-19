import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';

/// User's provider.
final StateProvider<List<User>> usersProvider = StateProvider<List<User>>(
  (Ref ref) => <User>[],
);

/// Create user provider by user id.
final ProviderFamily<User?, String> createUserProvider =
    Provider.family<User?, String>((Ref ref, String id) {
  return ref.watch<User?>(
    usersProvider.select<User?>((List<User> users) {
      final int index = users.indexWhere((User user) => user.id == id);

      // If user found, return it.
      if (index != -1) {
        return users[index];
      }

      return null;
    }),
  );
});

/// Fetch user.
final AutoDisposeFutureProviderFamily<User, String> remoteUserProvider =
    FutureProvider.autoDispose.family<User, String>(
  (Ref ref, String id) async {
    final User user = await socfonyService.findUser(StringValue()..value = id);

    return user..save(ref.read);
  },
);

/// Extension for user's provider.
extension UsersProviderExtension on StateProvider<List<User>> {
  /// Of a user by ID.
  /// Returns null if user not found.
  Provider<User?> of(String id) => createUserProvider(id);

  /// Can user be found by ID?
  bool contains(Reader reader, String id) {
    return reader(this).any((element) => element.id == id);
  }

  /// Update a user.
  void update(Reader reader, User Function() updates) {
    final User updated = updates();

    reader(state).update(
      (users) => [
        for (final User user in users)
          if (user.id == updated.id) user.merge(updated) else user,
      ],
    );
  }

  /// Update or set a user.
  void upset(Reader reader, User user) {
    assert(user.hasId() && user.id.isNotEmpty, 'User must have an id');

    // If user already exists, update it.
    if (contains(reader, user.id)) {
      return update(reader, () => user);
    }

    // Otherwise, add it.
    reader(state).update((state) => [...state, user]);
  }

  /// Remove a user.
  void remove(Reader reader, String id) {
    reader(state).update(
      (users) => users.where((User user) => user.id != id).toList(),
    );
  }

  /// Fetch a user.
  AutoDisposeFutureProvider<User> remote(String id) => remoteUserProvider(id);
}

/// Extension for user.
extension UserExtension on User {
  /// Merge user, create a new user.
  User merge(User other) => User()
    ..mergeFromMessage(this)
    ..mergeFromMessage(other);

  /// Save the user, if not exists, create a new user.
  void save(Reader reader) {
    assert(hasId() && id.isNotEmpty, 'User must have an id');

    usersProvider.upset(reader, this);
  }

  /// Remove the user.
  static void destroy(Reader reader, String id) =>
      usersProvider.remove(reader, id);

  /// Create a remote user.
  static AsyncValue<User> remote(Reader reader, String id) =>
      reader(usersProvider.remote(id));

  /// Find a user in user's provider.
  static User? find(Reader reader, String id) => reader(usersProvider.of(id));
}
