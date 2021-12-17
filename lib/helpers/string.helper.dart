// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math';

class StringHelper {
  const StringHelper._();

  static Random get _random {
    try {
      return Random.secure();
    } catch (e) {
      return Random();
    }
  }

  /// Using custom alphabet to generate random strings
  ///
  /// [alphabet] is a string of characters to use in the random string
  ///
  /// [length] is the length of the random string to generate
  static String custom(String alphabet, int length) {
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      buffer.write(alphabet[_random.nextInt(alphabet.length)]);
    }

    return buffer.toString();
  }

  /// Generate a random string of length [length]
  ///
  /// alphabet used is [a-zA-Z0-9_-]
  ///
  /// [length] is the length of the random string to generate
  static String string(int length) => custom(
      r'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-',
      length);

  /// Generate a numeric string of length [length]
  ///
  /// [length] is the length of the random string to generate
  static String numeric(int length) => custom(r'0123456789', length);
}
