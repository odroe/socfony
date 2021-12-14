// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// Container factory creator type.
typedef ContainerCreator<T> = T Function(Container);

/// Singleton container.
///
/// This class is used to create lazy containers.
///
/// Example:
/// ```dart
/// final container = Container()
///   // Register a singleton.
///   ..registerSingleton<MyClass>(MyClass())
///   // Register a factory.
///   ..register<MyClass>(() => MyClass())
/// ;
///
/// // Get a singleton.
/// final myClass = container.get<MyClass>();
///
/// // The container has a self reference
/// final container2 = container.get<Container>();
///
/// print(container == container2); // true
/// ```
class Container {
  /// The container instance.
  static Container? _instance;

  /// Create a new container.
  const Container._();

  /// Create the container instance.
  factory Container() =>
      (_instance ??= const Container._())..registerSingleton(_instance);

  /// List of registered singletons.
  static final List<dynamic> _singletons = [];

  /// Map of registered singletons by name.
  static final Map<String, dynamic> _namedSingletons = {};

  /// Validate the singleton name.
  ///
  /// [name] The name to validate.
  ///
  /// Throws [ArgumentError] if the name is not valid.
  String? _validateName(String? name) {
    if (name != null && name.isEmpty) {
      throw ArgumentError('Name cannot be empty.');
    }

    return name;
  }

  /// Register a singleton using a factory.
  ///
  /// [creator] The factory to create the singleton.
  ///
  /// [name] The name of the singleton.
  void register<T>(ContainerCreator<T> creator, {String? name}) =>
      registerSingleton(creator, name: name);

  /// Register a singleton.
  ///
  /// [singleton] The singleton to register.
  ///
  /// [name] The name of the singleton.
  void registerSingleton<T>(T instance, {String? name}) {
    final String? validatedName = _validateName(name);
    if (validatedName != null) {
      _namedSingletons[name!] = instance;
    } else {
      _singletons.removeWhere((object) => object is T);
      _singletons.add(instance);
    }
  }

  /// Get a singleton.
  ///
  /// [T] The type of the singleton.
  ///
  /// [name] The name of the singleton.
  T get<T>([String? name]) {
    final T? result = _getIsInstanceOrNull<T>(name);
    if (result == null) {
      return _getIsCreator<T>(name);
    }

    return result;
  }

  /// Get a singletion is creator.
  ///
  /// [T] The type of the singleton.
  ///
  /// [name] The name of the singleton.
  ///
  /// Throws [ArgumentError] if the name is not valid.
  T _getIsCreator<T>(String? name) {
    final ContainerCreator<T>? creator = _getIsCreatorOrNull<T>(name);
    if (creator == null) {
      throw ArgumentError('No creator found for type $T.');
    }

    final result = creator(this);
    registerSingleton<T>(result, name: name);

    return result;
  }

  /// Get Creator or null.
  ///
  /// [T] The type of the singleton.
  ///
  /// [name] The name of the singleton.
  ContainerCreator<T>? _getIsCreatorOrNull<T>(String? name) =>
      _getIsInstanceOrNull<ContainerCreator<T>>(name);

  /// Get a singleton is instance.
  ///
  /// [T] The type of the singleton.
  T? _getIsInstanceOrNull<T>(String? name) {
    final String? validatedName = _validateName(name);
    if (validatedName != null) {
      return _namedSingletons[name] as T;
    }

    final typeList = _singletons.whereType<T>();
    if (typeList.isNotEmpty) {
      return typeList.single;
    }

    final typedMapValues = _namedSingletons.values.whereType<T>();
    if (typedMapValues.isNotEmpty) {
      return typedMapValues.single;
    }

    return null;
  }
}
