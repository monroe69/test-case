import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tes_api/routes/routes.dart';
import 'package:tes_api/view/beranda/tesmain.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../model/modelnote.dart';

class authcontroller extends GetxController {
   RxBool passwordIsHidden = true.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
   var Ischecked = false.obs;
   
   
   @override
  void onInit() {
    super.onInit();
  }

  void toggleCheckbox(String id) {
    Ischecked.value = !Ischecked.value; 
  }

  @override
  void onClose() {
    super.onClose();
  }
  
  @override
  void onReady() {
    super.onReady();
  }
  Stream<User?> stremAuthStatus() {
    return auth.authStateChanges();
  }

  var isButtonPressed = false.obs;

  final Map<String, bool> itemStatus = <String, bool>{}.obs;

  void toggleItemStatus(String uid) {
    if (itemStatus.containsKey(uid)) {
      itemStatus[uid] = !itemStatus[uid]!;
    } else {
      itemStatus[uid] = true;
    }
  }

  RxBool isLoading = false.obs;
  final _storage = GetStorage();

  void login(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential Myuser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = auth.currentUser;

      if (user != null) {
        List<String?> providerList = [];
        for (final providerProfile in user.providerData) {
          final provider = providerProfile.providerId;

          print('PROVIDER ID: $provider');
          providerList.add(provider);
          _storage.write('provider', providerList);
          providerList.add(provider);
          _storage.write('provider', providerList);
        }
        isLoading.value = false;
      }

      if (user!.emailVerified == true) {
        Get.offAllNamed(TodoRoute.Home);
      } else {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Mohon Verifikasi email anda $email",
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print('FIREBASE AUTH EXCEPTION : ${e.code}');
    }
  }

//signup
  Future signup(String email, String password) async {
    try {
      if (password.length < 8) {
        Get.defaultDialog(
          title: "Password Error",
          middleText: "Password harus memiliki minimal 8 karakter.",
          onConfirm: () {
            Get.back();
          },
          textConfirm: "Oke",
        );
        return; // Exit the function since the password is too weak
      }
      UserCredential Myuser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await Myuser.user?.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection('auth')
          .doc(Myuser.user!.uid)
          .set({'email': email, 'password': password, 'uid': Myuser.user?.uid});

      Get.defaultDialog(
          title: "Verifikasi email",
          middleText: "Kami telah mengirimkan email verifikasi ke $email",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "Ya,Saya akan cek email");

      String userId = Myuser.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
            title: "Password Error",
            middleText: "Mohon Periksa Kembali password anda",
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: "Oke");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addnote(
      String title, String date, String status, String prioritas) async {
    try {
      Get.defaultDialog(
          title: 'Task',
          middleText: 'Yakin ingin lanjutkan',
          confirm: ElevatedButton(
              onPressed: () {
                var uuid = const Uuid().v4();
                firestore
                    .collection('auth')
                    .doc(auth.currentUser!.uid)
                    .collection('notes')
                    .doc(uuid)
                    .set({
                  'id': uuid,
                  'title': title,
                  'date': date,
                  'status': status,
                  'prioritas': prioritas,
                  'isDon': false,
                });
                Get.to(beranda());
              },
              child: const Text("Ya,lanjutkan")),
          cancel: ElevatedButton(
              onPressed: () => Get.back(), child: const Text("Kembali")));

      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> filterbydate(
      DateTime selectedDate) {
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('auth')
        .doc(uid)
        .collection('notes')
        .where('date',
            isEqualTo:
                selectedDate)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getnotes() {
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('auth')
        .doc(uid)
        .collection('notes')
        .doc(uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserDocument() {
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('auth')
        .doc(uid)
        .collection('notes')
        .orderBy('title')
        .snapshots();
  }
    Stream<QuerySnapshot<Map<String, dynamic>>> orderbyprioritas() {
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('auth')
        .doc(uid)
        .collection('notes')
        .orderBy('prioritas')
        .snapshots();
  }
    Stream<QuerySnapshot<Map<String, dynamic>>> orderbydate() {
    String uid = auth.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('auth')
        .doc(uid)
        .collection('notes')
        .orderBy('date')
        .snapshots();
  }

  Stream<QuerySnapshot> stream() {
    return firestore
        .collection('auth')
        .doc(auth.currentUser!.uid)
        .collection('notes')
        .where('isDon')
        .snapshots();
  }

  void delete() {
    var uuid = const Uuid().v4();
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("").doc(uuid);
  }

  Future<void> deleteNote(String noteId) async {
    try {
      String uid = auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('auth')
          .doc(uid)
          .collection('notes')
          .doc(noteId)
          .delete();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  Future<bool> isdone(String uuid, bool isDon) async {
    try {
      await firestore
          .collection('auth')
          .doc(auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDon': isDon});
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.toNamed('/log-in');
  }


 Future<bool> edit(Map<String, dynamic> updatedData, String uid) async {
  try {
    await firestore
          .collection('auth')
          .doc(auth.currentUser!.uid)
          .collection('notes')
          .doc(uid)
          .update(updatedData); 
          Get.to(beranda());
        return true;
  } catch (e) {
    print(e);
    return false;
  }
}


}
