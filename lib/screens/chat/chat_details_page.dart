import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/models/xin/send_message_model.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_chat_app_ui/apis/fake_data/backend/api_config.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/backend/api_response.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/backend/message_service.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/models/xin/message_model.dart';

class ChatDetailPage extends StatefulWidget {
  String userto;
  ChatDetailPage({
    Key? key,
    required this.userto,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _msgTxtEditing = TextEditingController();
  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  final StreamController _streamController = StreamController();
  String name = "";
  String image = "";

  MessageService get service => GetIt.I<MessageService>();
  late APIResponse<List<MessageModel>> _apiResponse;
  final bool _isLoading = false;
  var dataStream;

  Stream messagesStream() async* {
    while (true) {
      dataStream = await service
          .getAllMyMessagesWith(ApiConfig.userIdDefault, widget.userto)
          .then((value) => value);
      yield dataStream;
    }
  }

  @override
  void initState() {
    messagesStream();
    // _fetchMessages();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    name = widget.userto;
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                image != ""
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(image),
                        maxRadius: 20,
                      )
                    : const CircleAvatar(
                        maxRadius: 20,
                      ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white0),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: AppColors.greyshade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.more_vert_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
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
                      List<MessageModel>? messages = dataStream.data;
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages!.length,
                        shrinkWrap: true,
                        reverse: true,
                        // padding: const EdgeInsets.only(top: 10, bottom: 10),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment:
                                      (messages[index].message_from == name
                                          ? Alignment.topLeft
                                          : Alignment.topRight),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width <
                                            500
                                        ? MediaQuery.of(context).size.width *
                                            0.8
                                        : MediaQuery.of(context).size.width *
                                            0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: (messages[index]
                                                  .message_from ==
                                              name
                                          ? const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            )
                                          : const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            )),
                                      color:
                                          (messages[index].message_from == name
                                              ? AppColors.primaryGrey
                                              : AppColors.primaryLight),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      messages[index].message_text,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: AppColors.white0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("No Message."),
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
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              // height: 80.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.photo),
                        iconSize: 25.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                            minLines: 1,
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            onChanged: (value) {},
                            controller: _msgTxtEditing,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Send a message...',
                            ),
                            onTap: () {
                              // _scrollController.animateTo(
                              //     _scrollController.position.maxScrollExtent,
                              //     duration: const Duration(milliseconds: 300),
                              //     curve: Curves.easeOut);
                            }),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        iconSize: 25.0,
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (_msgTxtEditing.text.isNotEmpty) {
                            SendMessageModel themessage = SendMessageModel(
                              "",
                              _msgTxtEditing.text,
                              ApiConfig.userIdDefault,
                              name,
                              "",
                              DateTime.now().toString(),
                              0,
                            );
                            APIResponse<bool> send = await service.sendMessage(
                                ApiConfig.userIdDefault, name, themessage);
                            if (send.error) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: Center(
                                        child: Text(
                                          send.errorMessage.toString(),
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              child: const Text("Ok"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            }
                            _msgTxtEditing.clear();
                            // setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
