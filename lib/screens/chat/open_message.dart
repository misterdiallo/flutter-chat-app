import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/models/group_chat_model.dart';
import 'package:flutter_chat_app_ui/models/user_model.dart';
import 'package:flutter_chat_app_ui/screens/chat/chat_group_page.dart';
import 'package:flutter_chat_app_ui/screens/chat/simple_chat_page.dart';

openMessage(context, List<UserModel> people) {
  if (people.length > 1) {
    // ! Create the group

    // !  Open the group conversation
    GroupChatModel group = GroupChatModel(
        001,
        "group_name",
        "group_description",
        people,
        UserModel(
          userid: 20,
          fullname: "Mamadou Alpha Diallo",
          alias: "Alpha Diallo ",
          sex: "Male",
          email: "misterdiallo@outlook.com ",
          phone: "+8618354919254",
          description:
              "I'm Alpha diallo, A Data Scientist, full-stack developer and entreprener.",
          picture: "profile.jpg",
        ),
        "group_link",
        "");

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return GroupChatPage(group: group);
        },
        // fullscreenDialog: true,
      ),
    );
  } else {
    //! Check if there's existing message already

    //! Open the message
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SimpleChatPage(user: people[0]);
        },
        // fullscreenDialog: true,
      ),
    );
  }
}
