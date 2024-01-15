import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/auth/controller/auth_controller.dart';
import 'package:user_management/auth/model/login_request.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/shared/validators.dart';
import 'package:user_management/shared/widget/custom_text_field.dart';
import 'package:user_management/user/ui/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstant.userName.capitalizeFirst!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: nameController,
                          validator: (value) {
                            return Validator.nameValidator(
                                value, StringConstant.userName);
                          },
                          hintText: StringConstant.userName,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          StringConstant.password.capitalizeFirst!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          validator: (value) {
                            return Validator.nameValidator(
                                value, StringConstant.password);
                          },
                          hintText: StringConstant.password.capitalizeFirst!,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text('username: kminchelle & password: 0lelplR'),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: FilledButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                LoginRequest request = LoginRequest(
                                    username: nameController.text,
                                    password: passwordController.text);
                                bool value =
                                    await authController.login(request);
                                if (value) {
                                  Get.off(const HomeScreen());
                                }
                              }
                            },
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Text(StringConstant.loginButtonText)),
                          ),
                        )
                      ],
                    ),
                    Obx(() {
                      if (authController.isLoading.value) {
                        return const Center(
                          child: ProgressIndicatorWidget(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                  ],
                ))));
  }
}
