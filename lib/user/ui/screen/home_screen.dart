import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
    Future.delayed(Duration.zero, () async {
      await userController.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: StringConstant.homeScreenTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: TextEditingController(),
              prefixIcon: const Icon(Icons.search),
              onChanged: userController.searchUsers,
              hintText: StringConstant.searchHintText,
            ),
            Expanded(
              child: Obx(() {
                final userList = userController.userSearchResults.toList();
                if (userController.isLoading.value) {
                  return const ProgressIndicatorWidget();
                } else if (userList.isEmpty) {
                  return const Center(child: Text(StringConstant.userNotFound));
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: userList.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return UserListTileWidget(
                        user: userList[index],
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
