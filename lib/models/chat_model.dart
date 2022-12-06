// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realpost/utility/app_constant.dart';

class ChatModel {
  final String message;
  final Timestamp timestamp;
  final String uidChat;
  final String disPlayName;
  final String urlAvatar;
  final String urlRealPost;

  ChatModel({
    required this.message,
    required this.timestamp,
    required this.uidChat,
    required this.disPlayName,
    required this.urlAvatar,
    required this.urlRealPost,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'timestamp': timestamp,
      'uidChat': uidChat,
      'disPlayName': disPlayName,
      'urlAvatar': urlAvatar,
      'urlRealPost': urlRealPost,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: (map['message'] ?? '') as String,
      timestamp: (map['timestamp']),
      uidChat: (map['uidChat'] ?? '') as String,
      disPlayName: (map['disPlayName'] ?? '') as String,
      urlAvatar: (map['urlAvatar'] ?? AppConstant.urlAvatar) as String,
      urlRealPost: (map['urlRealPost'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
