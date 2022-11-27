import 'dart:convert';

class ConversationModel {
  int id;
  String title;
  String imageURL;
  String message_to;
  String last_message;
  DateTime last_message_date;
  int totalNonRead;

  ConversationModel(
    this.id,
    this.title,
    this.imageURL,
    this.message_to,
    this.last_message,
    this.last_message_date,
    this.totalNonRead,
  );

  factory ConversationModel.allFromJson(Map<String, dynamic> map) {
    return ConversationModel(
      map['id'],
      map['title'],
      map['imageURL'],
      map['message_to'],
      map['last_message'],
      DateTime.parse(map['last_messsage_date']),
      map['totalNonRead'],
    );
  }

  ConversationModel copyWith({
    int? id,
    String? title,
    String? imageURL,
    String? message_to,
    String? last_message,
    DateTime? last_message_date,
    int? totalNonRead,
  }) {
    return ConversationModel(
      id ?? this.id,
      title ?? this.title,
      imageURL ?? this.imageURL,
      message_to ?? this.message_to,
      last_message ?? this.last_message,
      last_message_date ?? this.last_message_date,
      totalNonRead ?? this.totalNonRead,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'imageURL': imageURL});
    result.addAll({'message_to': message_to});
    result.addAll({'last_message': last_message});
    result.addAll(
        {'last_message_date': last_message_date.millisecondsSinceEpoch});
    result.addAll({'totalNonRead': totalNonRead});

    return result;
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['imageURL'] ?? '',
      map['message_to'] ?? '',
      map['last_message'] ?? '',
      DateTime.parse(map['last_message_date']),
      map['totalNonRead']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConversationModel(id: $id, title: $title, imageURL: $imageURL, message_to: $message_to, last_message: $last_message, last_message_date: $last_message_date, totalNonRead: $totalNonRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConversationModel &&
        other.id == id &&
        other.title == title &&
        other.imageURL == imageURL &&
        other.message_to == message_to &&
        other.last_message == last_message &&
        other.last_message_date == last_message_date &&
        other.totalNonRead == totalNonRead;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageURL.hashCode ^
        message_to.hashCode ^
        last_message.hashCode ^
        last_message_date.hashCode ^
        totalNonRead.hashCode;
  }
}
