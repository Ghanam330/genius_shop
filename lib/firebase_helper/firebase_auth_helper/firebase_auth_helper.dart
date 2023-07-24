import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:genius_shop/constants/constant.dart';

import '../../models/user_model/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  Stream<User?> get getAuthChange => _auth.authStateChanges();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      switch (error.code) {
        case "invalid-email":
          errorMessage = "يبدو أن عنوان بريدك الإلكتروني غير صحيح.";
          break;
        case "wrong-password":
          errorMessage = "كلمة المرور التي أدخلتها غير صحيحة.";
          break;
        case "user-not-found":
          errorMessage = "لم يتم العثور على مستخدم بهذا البريد الإلكتروني.";
          break;
        case "user-disabled":
          errorMessage = "تم تعطيل هذا المستخدم.";
          break;
        case "too-many-requests":
          errorMessage = "لقد حظرنا جميع محاولات هذا الجهاز للدخول إلى هذا الحساب. حاول مرة أخرى لاحقًا.";
          break;
        case "operation-not-allowed":
          errorMessage = "تم تعطيل تسجيل الدخول بواسطة البريد الإلكتروني وكلمة المرور.";
          break;
        case "ERROR_Email_Already_In_Use":
          errorMessage = "البريد الإلكتروني مستخدم بالفعل";
          break;
        default:
          errorMessage = "حدث خطأ غير معروف.";
      }
      showMessage(errorMessage!);
      return false;
    }
  }

  Future<bool> signUp(
      String name, String email, String password,String phone, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid, name: name, email: email, image: null, phone:phone );
      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  void signOut() async {
    await _auth.signOut();
  }


  Future<bool> changePassword(
      String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      // UserCredential userCredential = await _auth
      //     .createUserWithEmailAndPassword(email: email, password: password);
      // UserModel userModel = UserModel(
      //     id: userCredential.user!.uid, name: name, email: email, image: null);

      // _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context,rootNavigator: true).pop();
      showMessage("Password Changed");
      Navigator.of(context).pop();

      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
}
