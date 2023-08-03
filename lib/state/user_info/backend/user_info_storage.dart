import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:insta_whisp/state/constants/firestore_collection_names.dart';
import 'package:insta_whisp/state/constants/firestore_field_names.dart';
import 'package:insta_whisp/state/user_info/models/user_info.dart';
import 'package:insta_whisp/state/user_info/typedefs/user_id.dart';
import 'package:insta_whisp/utils/logger.dart';

@immutable
class UserInfoStorage {
  Future<void> saveUserInfo({
    required UserId userId,
    String? displayName,
    String? email,
  }) async {
    final filteredUserList = await FirebaseFirestore.instance
        .collection(FirestoreCollectionNames.users)
        .where(
          FirestoreFieldNames.uid,
          isEqualTo: userId,
        )
        .limit(1)
        .get()
        .then((value) => value.docs);

    if (filteredUserList.isEmpty) {
      'filteredUserList is Empty'.log();
      await FirebaseFirestore.instance
          .collection(FirestoreCollectionNames.users)
          .add(
            UserInfo(
              userId: userId,
              displayName: displayName,
              email: email,
            ).toMap(),
          );
    } else {
      'filteredUserList is Not Empty'.log();
      filteredUserList.first.reference.update({
        FirestoreFieldNames.email: email ?? '',
        FirestoreFieldNames.displayName: displayName ?? '',
      });
    }
  }
}
