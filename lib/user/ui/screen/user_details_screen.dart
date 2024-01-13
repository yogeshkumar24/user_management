import 'package:flutter/material.dart';
import 'package:user_management/user/model/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  const UserDetailsScreen({required this.userModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfo("Username", userModel.username),
            userInfo("Email", userModel.email),
            userInfo("Phone", userModel.phone),
            const SizedBox(height: 16),
            const Text(
              "Address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            userInfo("Street", userModel.address?.street),
            userInfo("City", userModel.address?.city),
          ],
        ),
      ),
    );
  }

  Widget userInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value ?? "-",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
