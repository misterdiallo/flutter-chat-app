import 'package:intl/intl.dart';

class SendMessageModel {
  String messageid;
  String message_text;
  String message_from;
  String message_to;
  String imageURL;
  String messageCreatedAt;
  int totalNonRead;

  SendMessageModel(
    this.messageid,
    this.message_text,
    this.message_from,
    this.message_to,
    this.imageURL,
    this.messageCreatedAt,
    this.totalNonRead,
  );

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateTime dateCreation = DateTime.parse(messageCreatedAt);
    final String formatted = formatter.format(dateCreation);
    return {
      "messageid": messageid,
      "message_text": message_text,
      "message_from": message_from,
      "message_to": message_to,
      "imageURL": imageURL,
      "formatted": formatted,
      "totalNonRead": totalNonRead,
    };
  }
}
