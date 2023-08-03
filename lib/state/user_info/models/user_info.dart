// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class UserInfo {
  final String userId;
  final String? displayName;
  final String? email;
  UserInfo({
    required this.userId,
    required this.displayName,
    required this.email,
  });

  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'display_name': displayName ?? '',
      'email': email ?? '',
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      userId: map['userId'] as String,
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) => UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserInfo(userId: $userId, displayName: $displayName, email: $email)';
}
