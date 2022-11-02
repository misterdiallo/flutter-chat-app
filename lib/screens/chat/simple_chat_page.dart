import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/messages.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/models/chat_message_model.dart';

import 'package:flutter_chat_app_ui/models/user_model.dart';
import 'package:flutter_chat_app_ui/screens/homepage.dart';

class SimpleChatPage extends StatefulWidget {
  UserModel user;
  SimpleChatPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _SimpleChatPageState createState() => _SimpleChatPageState();
}

class _SimpleChatPageState extends State<SimpleChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _msgTxtEditing = TextEditingController();
  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = widget.user;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
                pageBuilder: (context, firstAnimation, secondaryAnimation) {
                  return const HomePage();
                },
                transitionDuration: const Duration(seconds: 1)),
            (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        appBar: AppBar(
          elevation: 0,
          // automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 2,
                  ),
                  user.picture != ""
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.picture),
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
                          user.fullname,
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
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  shrinkWrap: true,
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
                                (messages[index].messageType == "receiver"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                            child: Container(
                              width: MediaQuery.of(context).size.width < 500
                                  ? MediaQuery.of(context).size.width * 0.8
                                  : MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius:
                                    (messages[index].messageType == "receiver"
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
                                    (messages[index].messageType == "receiver"
                                        ? AppColors.primaryGrey
                                        : AppColors.primaryLight),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                messages[index].messageContent,
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
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut);
                              }),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          iconSize: 25.0,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (_msgTxtEditing.text.isNotEmpty) {
                              messages.add(
                                ChatMessageModel(
                                    messageContent: _msgTxtEditing.text,
                                    messageType: "sender"),
                              );
                              _msgTxtEditing.clear();
                              setState(() {});
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
      ),
    );
  }
}
