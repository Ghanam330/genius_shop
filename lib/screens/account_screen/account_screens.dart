import 'package:flutter/material.dart';
import 'package:genius_shop/constants/strings.dart';
import 'package:provider/provider.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import '../../provider/app_provider.dart';
import '../about_us/about_us.dart';
import '../change_password/change_password.dart';
import '../chat_screen/chat_screen.dart';
import '../favourite_screen/fav_screen.dart';
import '../order_screen/order_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text("الحساب الشخصي",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 60,
                      ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appProvider.getUserInformation.email,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                // SizedBox(
                //   width: 130,
                //   child: PrimaryButton(
                //     title: "Edit Profile",
                //     onPressed: () {
                //       Routes.instance
                //           .push(widget:  ChatScreen(), context: context);
                //     },
                //   ),
                // )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const OrderScreen(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("الطلبات"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const FavouriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("المفضلة"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: ChatScreen(), context: context);
                  },
                  leading: const Icon(Icons.chat_outlined),
                  title: const Text("تواصل معنا"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget:AboutUs(), context: context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("عن المطور"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: PasswordResetScreen(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("تغيير كلمة المرور"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();

                    setState(() {
                      Navigator.pushNamedAndRemoveUntil(
                          context, loginScreen, (route) => false);
                    });
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("تسجيل الخروج"),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text("Version 1.0.0")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
