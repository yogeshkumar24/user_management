import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/user/controller/users_controller.dart';
import 'package:user_management/user/ui/screen/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // Future.delayed(Duration.zero, () async {
    await userController.fetchUsers();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              onChanged: (query) {
                userController.searchUsers(query);
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (userController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: userController.userSearchResults.length,
                    itemBuilder: (context, index) {
                      var user = userController.userSearchResults[index];
                      return user == null
                          ? const Center(
                              child: Text(
                                "No Data Available",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : ListTile(
                              onTap: () {
                                Get.to(UserDetailsScreen(
                                  userModel: userController.userList[index],
                                ));
                              },
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(
                                user.username!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    user.email!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    user.phone!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                              ),
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
