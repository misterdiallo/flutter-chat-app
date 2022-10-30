import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/models/chat_user_model.dart';
import 'package:flutter_chat_app_ui/screens/chat/chat_details_page.dart';

class ConversationList extends StatefulWidget {
  ChatUserModel model;
  ConversationList({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  ConversationListState createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    ChatUserModel model = widget.model;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChatDetailPage(
              user: model,
            );
          }),
        );
      },
      child: Container(
        color: Colors.transparent,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  ProfilePicture(
                    name: 'x',
                    radius: 21,
                    fontsize: 21,
                    random: true,
                    img: model.imageURL != "" ? model.imageURL : null,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          model.messageText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: model.totalNonRead > 0
                                        ? AppColors.primaryLight
                                        : Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .color,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.time,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: model.totalNonRead > 0
                            ? AppColors.primaryLight
                            : Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .color!
                                .withOpacity(0.5),
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                model.totalNonRead > 0
                    ? CircleAvatar(
                        radius: 11,
                        backgroundColor: appActiveColor,
                        child: Text(
                          model.totalNonRead.toInt() < 99
                              ? '${model.totalNonRead}'
                              : "+99",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 10.0, color: AppColors.white0),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
