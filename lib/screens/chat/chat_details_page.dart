import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/messages.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';

import 'package:flutter_chat_app_ui/models/chat_user_model.dart';

class ChatDetailPage extends StatefulWidget {
  ChatUserModel user;
  ChatDetailPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _msgFocus = FocusNode();
  final TextEditingController _msgTxtEditing = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  _scrollToBottom() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    ChatUserModel modelfromList = widget.user;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.white,
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
                    color: AppBarTheme.of(context).iconTheme!.color,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                modelfromList.imageURL != ""
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(modelfromList.imageURL),
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
                        modelfromList.name,
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
                  Icons.settings,
                  color: AppBarTheme.of(context).iconTheme!.color,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 120),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: (messages[index].messageType == "receiver"
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
                      color: (messages[index].messageType == "receiver"
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
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: appBbackground,
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 20, bottom: 10, top: 5, right: 20),
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: AppColors.primaryBleuBic.withOpacity(0.3),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                    top: 10,
                  ),
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.white0,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Form(
                          key: _formkey,
                          child: TextFormField(
                            textInputAction: TextInputAction.newline,
                            focusNode: _msgFocus,
                            keyboardType: TextInputType.multiline,
                            controller: _msgTxtEditing,
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.white0,
                              letterSpacing: 1,
                            ),
                            autofocus: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              suffixIcon: FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: AppColors.primaryLight,
                                elevation: 0,
                                child: const Icon(
                                  Icons.send,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
