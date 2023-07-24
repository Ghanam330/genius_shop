import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genius_shop/provider/app_provider.dart';
import 'package:provider/provider.dart';


class PasswordResetScreen extends StatefulWidget {
  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AppProvider>(context);

    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
              "إعادة تعيين كلمة المرور",
              style:TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        body: ListView(

          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
           const SizedBox(height: 36.0),
            TextFormField(
              controller: _emailController,
              obscureText: isShowPassword,
              decoration: const InputDecoration(
                hintText: "البريد الإلكتروني",
                prefixIcon:  Icon(
                  Icons.email_outlined,
                ),
              ),
            ),
            const SizedBox(height:36.0),
            ElevatedButton(
              onPressed: () {
                final email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  authProvider.forgotPassword(email);
                }
              },
              child: const Text('إرسال رابط إعادة تعيين كلمة المرور'),
            ),
          ],
        ),
      ),
    );
  }
}
