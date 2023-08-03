import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirestoreFieldNames {
  static const uid = 'user_id';
  static const displayName = 'display_name';
  static const email = 'email';
  static const createdAt = 'created_at';

  const FirestoreFieldNames._();
}
