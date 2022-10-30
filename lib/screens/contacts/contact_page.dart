import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/list_contact_user.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/models/contact_user_model.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final MultiSelectController<ContactUserModel> _controller =
      MultiSelectController();
  List<ContactUserModel> allselected = [];
  bool isMultiselection = false;

  // function isLink
  bool isLink(String initial) {
    return initial.startsWith("http://");
  }

  // Streamss.
  final Stream<List<ContactUserModel>> _contacts =
      Stream<List<ContactUserModel>>.fromIterable(
    <List<ContactUserModel>>[
      listContactsUser,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          leading: const BackButton(),
          centerTitle: !isMultiselection,
          elevation: 0,
          title: !isMultiselection
              ? const Text("Select Contact...")
              : Text("${allselected.length.toString()} people selected"),
          actions: [
            !isMultiselection
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isMultiselection = !isMultiselection;
                      });
                    },
                    icon: const Icon(
                      Icons.check_box_outline_blank_outlined,
                    ),
                  )
                : TextButton(
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onPressed: () {
                      setState(() {
                        isMultiselection = !isMultiselection;
                        allselected = [];
                      });
                    },
                  )
          ],
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ContactUserModel>>(
                stream: _contacts,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<ContactUserModel>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error while loading data!'),
                      );
                    } else if (snapshot.hasData) {
                      List<ContactUserModel> datas = snapshot.data!;
                      if (isMultiselection) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MultiSelectCheckList<ContactUserModel>(
                            animations: const MultiSelectAnimations(),
                            maxSelectableCount: 15,
                            textStyles: const MultiSelectTextStyles(
                                selectedTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            listViewSettings: ListViewSettings(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 0.2,
                                    )),
                            controller: _controller,
                            items: List.generate(
                              datas.length,
                              (index) => CheckListCard<ContactUserModel>(
                                value: listContactsUser[index],
                                title: Text(listContactsUser[index].fullname),
                                subtitle: Text(
                                  listContactsUser[index].description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                selectedColor: AppColors.primaryLight,
                                checkColor: AppColors.white0,
                                checkBoxBorderSide: const BorderSide(
                                    // color: Colors.yellow,
                                    ),
                                decorations: const MultiSelectItemDecorations(
                                  decoration: BoxDecoration(
                                    color: AppColors.transparent,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: AppColors.primaryGrey,
                                  ),
                                ),
                              ),
                            ),
                            onChange: (allSelectedItems, selectedItem) {
                              setState(() {
                                allselected = allSelectedItems;
                              });
                              // print(selectedItem);
                              // print(allSelectedItems);
                            },
                            onMaximumSelected:
                                (allSelectedItems, selectedItem) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'The limit has been reached',
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: datas.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 18),
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            ContactUserModel data = datas[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: isLink(data.picture.toString())
                                    ? Image.network(data.picture).image
                                    : AssetImage(
                                        'assets/img/${data.picture}',
                                      ),
                              ),
                              title: Text(data.fullname),
                              subtitle: Text(
                                data.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                print("Creating a simple chat....");
                              },
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(child: Text('No contact'));
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: _sendToUsersList.isNotEmpty
            //       ? Container(
            //           // height: 70,
            //           decoration: const BoxDecoration(
            //             color: AppColors.primaryBleuBic,
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15.0, vertical: 10),
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: Text(
            //                     _sendToUsersList
            //                         .map(
            //                           (e) => e.values.map((f) => f.fullname),
            //                         )
            //                         .join(" ~ ")
            //                         // .toList()
            //                         .toString()
            //                         .replaceAll(RegExp(r'\)'), "")
            //                         .toString()
            //                         .replaceAll(RegExp(r'\('), "")
            //                         .toString(),
            //                     softWrap: true,
            //                   ),
            //                 ),
            //                 IconButton(
            //                     onPressed: () {},
            //                     icon: const Icon(
            //                       Icons.send,
            //                       size: 25,
            //                       color: AppColors.primaryDark,
            //                     ))
            //               ],
            //             ),
            //           ),
            //         )
            //       : const SizedBox(),
            // )
          ],
        ),
      ),
      floatingActionButton: isMultiselection
          ? allselected.length > 2
              ? FloatingActionButton(
                  onPressed: () {
                    if (isMultiselection && allselected.length > 2) {
                      print("Creating the chat group...");
                    }
                  },
                  backgroundColor: AppColors.primaryLight,
                  elevation: 10,
                  child: const Icon(
                    Icons.done_all_outlined,
                    color: AppColors.white0,
                  ),
                )
              : null
          : null,
    );
  }
}
