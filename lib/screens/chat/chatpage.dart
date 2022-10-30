import 'package:flutter/material.dart';

import 'package:flutter_chat_app_ui/apis/fake_data/list_chat_user.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/screens/chat/widgets/conversation_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.primaryLight,
                          ),
                          child: GestureDetector(
                            onTap: () {},
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
                                  style: Theme.of(context).textTheme.bodySmall,
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
              child: ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 18),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (
                  context,
                  index,
                ) {
                  return ConversationList(
                    model: chatUsers[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
