import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String imageUrl;
  final String text;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.imageUrl,
    required this.text,
    required this.timestamp,
  });

  Post copyWith({String? imageUrl}) {
    return Post(
      id: id,
      userId: userId,
      userName: userName,
      imageUrl: imageUrl ?? this.imageUrl,
      text: text,
      timestamp: timestamp,
    );
  }

  // convert post -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': userName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
