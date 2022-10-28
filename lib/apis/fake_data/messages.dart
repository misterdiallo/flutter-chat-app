import 'package:flutter_chat_app_ui/models/chat_message_model.dart';

List<ChatMessageModel> messages = [
  ChatMessageModel(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "How have you been?", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender"),
  ChatMessageModel(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
];
