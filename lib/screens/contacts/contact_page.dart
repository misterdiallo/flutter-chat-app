import 'package:flutter/material.dart';
import 'package:flutter_chat_app_ui/apis/fake_data/list_user.dart';
import 'package:flutter_chat_app_ui/designs/colors.dart';
import 'package:flutter_chat_app_ui/models/user_model.dart';
import 'package:flutter_chat_app_ui/screens/chat/open_message.dart';
import 'package:flutter_chat_app_ui/screens/homepage.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final MultiSelectController<UserModel> _controller = MultiSelectController();
  List<UserModel> allselected = [];
  bool isMultiselection = false;

  // function isLink
  bool isLink(String initial) {
    return initial.startsWith("http://");
  }

  // Streamss.
  final Stream<List<UserModel>> _contacts =
      Stream<List<UserModel>>.fromIterable(
    <List<UserModel>>[
      listUsers,
    ],
  );

  @override
  Widget build(BuildContext context) {
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
                child: StreamBuilder<List<UserModel>>(
                  stream: _contacts,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<UserModel>> snapshot,
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
                        List<UserModel> datas = snapshot.data!;
                        if (isMultiselection) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MultiSelectCheckList<UserModel>(
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
                                (index) => CheckListCard<UserModel>(
                                  value: listUsers[index],
                                  title: Text(listUsers[index].fullname),
                                  subtitle: Text(
                                    listUsers[index].description,
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
                              UserModel data = datas[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      isLink(data.picture.toString())
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
                                onTap: () => openMessage(context, [data]),
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
            ],
          ),
        ),
        floatingActionButton: isMultiselection
            ? allselected.length > 2
                ? FloatingActionButton(
                    onPressed: () {
                      if (isMultiselection && allselected.length > 2) {
                        print("Creating the chat group...");
                        openMessage(context, allselected);
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
      ),
    );
  }
}
