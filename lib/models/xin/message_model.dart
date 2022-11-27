import 'dart:convert';

class MessageModel {
  dynamic id;
  String messageId;
  String message_text;
  String message_from;
  String message_to;
  String imageURL;
  DateTime messageCreatedAt;
  int totalNonRead;

  MessageModel(
    this.id,
    this.messageId,
    this.message_text,
    this.message_from,
    this.message_to,
    this.imageURL,
    this.messageCreatedAt,
    this.totalNonRead,
  );

  MessageModel copyWith({
    dynamic? id,
    String? messageId,
    String? message_text,
    String? message_from,
    String? message_to,
    String? imageURL,
    DateTime? messageCreatedAt,
    int? totalNonRead,
  }) {
    return MessageModel(
      id ?? this.id,
      messageId ?? this.messageId,
      message_text ?? this.message_text,
      message_from ?? this.message_from,
      message_to ?? this.message_to,
      imageURL ?? this.imageURL,
      messageCreatedAt ?? this.messageCreatedAt,
      totalNonRead ?? this.totalNonRead,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'messageId': messageId});
    result.addAll({'message_text': message_text});
    result.addAll({'message_from': message_from});
    result.addAll({'message_to': message_to});
    result.addAll({'imageURL': imageURL});
    result
        .addAll({'messageCreatedAt': messageCreatedAt.millisecondsSinceEpoch});
    result.addAll({'totalNonRead': totalNonRead});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      map['id'],
      map['messageId'] ?? '',
      map['message_text'] ?? '',
      map['message_from'] ?? '',
      map['message_to'] ?? '',
      map['imageURL'] ?? '',
      DateTime.parse(map['messageCreatedAt']),
      map['totalNonRead']?.toInt() ?? 0,
    );
  }
  factory MessageModel.allFromJson(Map<String, dynamic> item) {
    return MessageModel(
      item['id'],
      item['messageId'],
      item['message_text'],
      item['message_from'],
      item['message_to'],
      item['imageURL'],
      DateTime.parse(item['messageCreatedAt']),
      item['totalNonRead']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, messageId: $messageId, message_text: $message_text, message_from: $message_from, message_to: $message_to, imageURL: $imageURL, messageCreatedAt: $messageCreatedAt, totalNonRead: $totalNonRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.id == id &&
        other.messageId == messageId &&
        other.message_text == message_text &&
        other.message_from == message_from &&
        other.message_to == message_to &&
        other.imageURL == imageURL &&
        other.messageCreatedAt == messageCreatedAt &&
        other.totalNonRead == totalNonRead;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        messageId.hashCode ^
        message_text.hashCode ^
        message_from.hashCode ^
        message_to.hashCode ^
        imageURL.hashCode ^
        messageCreatedAt.hashCode ^
        totalNonRead.hashCode;
  }
}
