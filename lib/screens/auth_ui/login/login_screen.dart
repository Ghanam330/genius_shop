import 'package:flutter/material.dart';
import 'package:genius_shop/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../constants/constant.dart';
import '../../../constants/strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/option_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              right: 20,
              left: 20,
            ),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Welcome Back,",
                        fontSize: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'Sign in to Continue',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                    controller: emailController,
                    label: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  defaultFormField(
                    controller: passwordController,
                    suffix: suffix,
                    isPassword: isPassword,
                    suffixPressed: () {
                      changePasswordVisibility();
                    },
                    type: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'password is too short';
                      }
                      return null;
                    },
                    label: 'Password',
                    prefix: Icons.lock_outline,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, resetPasswordScreen, (route) => false);
                    },
                    text: 'Forget Password?',
                    fontSize: 14,
                    alignment: Alignment.topRight,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        bool isLogin = await  FirebaseAuthHelper.instance.login(
                          emailController.text,
                          passwordController.text,
                          context,
                        );
                        if (isLogin) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(
                              context, homeScreen, (route) => false);
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OptionButton(
                    desc: 'Don\'t have an account? ',
                    method: 'Sign Up',
                    onPressHandler: () {
                      Navigator.of(context).pushReplacementNamed(signupScreen);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    setState(() {});
  }
}
