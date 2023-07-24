import 'package:flutter/material.dart';
import '../../../constants/constant.dart';
import '../../../constants/strings.dart';
import '../../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/option_button.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
              context, loginScreen, (route) => false),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    CustomText(
                      text: 'انشاء حساب جديد',
                      fontSize: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'سجل الان لتستمتع بالتسوق',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل اسم المستخدم';
                        }
                        return null;
                      },
                      label: 'الاسم',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل البريد الالكتروني';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ('من فضلك ادخل بريد الكتروني صحيح');
                        }
                        return null;
                      },
                      label: 'الايميل',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      suffix: suffix,
                      onSubmit: (value) {},
                      isPassword: isPassword,
                      suffixPressed: () {
                        changePasswordVisibility();
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الرقم السري';
                        }
                        return null;
                      },
                      label: 'الرقم السري',
                      prefix: Icons.lock_outline,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم الهاتف';
                        } else if (value.length < 11) {
                          return 'من فضلك ادخل رقم هاتف صحيح';
                        }
                        return null;
                      },
                      label: 'رقم الهاتف',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_globalKey.currentState!.validate()) {
                          bool isLogin = await FirebaseAuthHelper.instance.signUp(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              phoneController.text,
                              context);
                          if (isLogin) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(
                                context, homeScreen, (route) => false);
                          }
                        }
                      },
                      child: const Text('انشاء حساب'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OptionButton(
                      desc: 'لديك حساب بالفعل؟',
                      method: 'تسجيل الدخول',
                      onPressHandler: () {
                        Navigator.of(context).pushReplacementNamed(loginScreen);
                      },
                    ),
                  ],
                ),
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
