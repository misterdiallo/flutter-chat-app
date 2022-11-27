import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/backend/api_config.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/backend/api_response.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/backend/message_service.dart';

import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/models/xin/conversation_model.dart';
import 'package:flutter_chat_app_ui/screens/chat/widgets/conversation_list.dart';
import 'package:flutter_chat_app_ui/screens/contacts/contact_page.dart';
import 'package:get_it/get_it.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  MessageService get service => GetIt.I<MessageService>();
  late APIResponse<List<ConversationModel>> _apiResponse;
  bool _isLoading = false;
  Future<void> _fetchMessages() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getAllMyConversations(ApiConfig.userIdDefault);
    setState(() {
      _isLoading = false;
    });
  }

  var dataStream;
  final streamController = StreamController();
  Stream messagesStream() async* {
    while (true) {
      dataStream = await service
          .getAllMyConversations(ApiConfig.userIdDefault)
          .then((value) => value);
      // streamController.add(dataStream);
      // streamController.stream.listen((event) {
      //   print(event);
      // });

      yield dataStream;
    }
  }

  @override
  void initState() {
    _fetchMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //! Header
          SafeArea(
            child: Material(
              color: AppColors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Chats",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const ContactPage();
                                },
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.primaryLight,
                            ),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.add,
                                  color: AppColors.white0,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "New Chat",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: AppColors.white0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // //! Search
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 16, left: 16, right: 16),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: "Search...",
                  //       hintStyle: TextStyle(color: Colors.grey.shade600),
                  //       prefixIcon: Icon(
                  //         Icons.search,
                  //         color: Colors.grey.shade600,
                  //         size: 20,
                  //       ),
                  //       filled: true,
                  //       fillColor: Colors.grey.shade100,
                  //       contentPadding: const EdgeInsets.all(8),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //           borderSide:
                  //               BorderSide(color: Colors.grey.shade100)),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10.0,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 3,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: StreamBuilder(
                stream: messagesStream(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(_apiResponse.errorMessage),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List<ConversationModel> listMessages = dataStream.data;
                      return ListView.builder(
                        itemCount: listMessages.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 18),
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return ConversationList(
                            model: listMessages[index],
                          );
                        },
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("No Conversation."),
                        ),
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('State: ${snapshot.connectionState}'),
                      ),
                    );
                  }
                },
              ),

              // ListView.builder(
              //   itemCount: chatUsers.length,
              //   shrinkWrap: true,
              //   padding: const EdgeInsets.only(top: 18),
              //   // physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (
              //     context,
              //     index,
              //   ) {
              //     return ConversationList(
              //       model: chatUsers[index],
              //     );
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
