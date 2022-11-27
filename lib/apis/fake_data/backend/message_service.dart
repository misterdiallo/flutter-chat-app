import 'dart:convert';

import 'package:flutter_chat_app_ui/apis/fake_data/backend/api_config.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/backend/api_response.dart';
import 'package:flutter_chat_app_ui/models/xin/conversation_model.dart';
import 'package:flutter_chat_app_ui/models/xin/message_model.dart';
import 'package:flutter_chat_app_ui/models/xin/send_message_model.dart';
import 'package:http/http.dart' as http;

class MessageService {
  Future<APIResponse<List<ConversationModel>>> getAllMyConversations(
      String userId) async {
    Uri url = Uri.parse("${ApiConfig.url}/listmessage/user/$userId");
    return http.get(url).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(data.bodyBytes));
        final conversationList = <ConversationModel>[];
        for (var item in jsonData) {
          conversationList.add(ConversationModel.allFromJson(item));
        }

        return APIResponse<List<ConversationModel>>(
          data: conversationList,
        );
      }
      return APIResponse<List<ConversationModel>>(
        error: true,
        errorMessage: data.body,
      );
    }).catchError((e) => APIResponse<List<ConversationModel>>(
          error: true,
          errorMessage: e.toString(),
        ));
  }

  Future<APIResponse<List<MessageModel>>> getAllMyMessagesWith(
      String from, String to) async {
    Uri url = Uri.parse("${ApiConfig.url}/listmessage/$from/$to");
    return http.get(url).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(utf8.decode(data.bodyBytes));
        final conversationList = <MessageModel>[];
        for (var item in jsonData) {
          conversationList.add(MessageModel.allFromJson(item));
        }

        return APIResponse<List<MessageModel>>(
          data: conversationList,
        );
      }
      return APIResponse<List<MessageModel>>(
        error: true,
        errorMessage: data.body,
      );
    }).catchError((e) => APIResponse<List<MessageModel>>(
          error: true,
          errorMessage: e.toString(),
        ));
  }

  Future<APIResponse<bool>> sendMessage(
      String from, String to, SendMessageModel item) async {
    Uri url = Uri.parse("${ApiConfig.url}/chat/save/$from/$to");
    return http
        .post(url, headers: ApiConfig.headears, body: jsonEncode(item.toJson()))
        .then((data) async {
      if (data.statusCode == 200) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(
        error: true,
        errorMessage: data.body,
      );
    }).catchError((e) => APIResponse<bool>(
              error: true,
              errorMessage: e.toString(),
            ));
  }
}
