import 'dart:convert';

class ChatUserModel {
  String name;
  String messageText;
  String imageURL;
  String time;
  int totalNonRead;
  ChatUserModel({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.time,
    required this.totalNonRead,
  });

  ChatUserModel copyWith({
    String? name,
    String? messageText,
    String? imageURL,
    String? time,
    int? totalNonRead,
  }) {
    return ChatUserModel(
      name: name ?? this.name,
      messageText: messageText ?? this.messageText,
      imageURL: imageURL ?? this.imageURL,
      time: time ?? this.time,
      totalNonRead: totalNonRead ?? this.totalNonRead,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'messageText': messageText});
    result.addAll({'imageURL': imageURL});
    result.addAll({'time': time});
    result.addAll({'totalNonRead': totalNonRead});

    return result;
  }

  factory ChatUserModel.fromMap(Map<String, dynamic> map) {
    return ChatUserModel(
      name: map['name'] ?? '',
      messageText: map['messageText'] ?? '',
      imageURL: map['imageURL'] ?? '',
      time: map['time'] ?? '',
      totalNonRead: map['totalNonRead']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUserModel.fromJson(String source) =>
      ChatUserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatUserModel(name: $name, messageText: $messageText, imageURL: $imageURL, time: $time, totalNonRead: $totalNonRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatUserModel &&
        other.name == name &&
        other.messageText == messageText &&
        other.imageURL == imageURL &&
        other.time == time &&
        other.totalNonRead == totalNonRead;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        messageText.hashCode ^
        imageURL.hashCode ^
        time.hashCode ^
        totalNonRead.hashCode;
  }
}
