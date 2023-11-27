import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:tes_api/controller/authcontroller.dart';
import 'package:tes_api/primary_textfield.dart';
import 'package:tes_api/view/auth/sign-in.dart';
import 'package:tes_api/view/beranda/tesmain.dart';

class Login extends GetView<authcontroller> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  @override
  Widget build(BuildContext context) {

    var size = 10 * 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 34, right: 34),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                
             
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Silakan masuk ke akun Anda!",
                  style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold,),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Test Case",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  height: 60,
                  width: 292,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: emailC,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 60,
                  width: 292,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey),
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(
                        () => PrimaryTextfield(
                          hintText: 'Password',
                          controller: passwordC,
                          obscureText:
                              controller.passwordIsHidden.value == true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.passwordIsHidden.toggle();
                            },
                            icon: controller.passwordIsHidden.value == true
                                ? const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 170),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xff545F71)),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () => controller.login(emailC.text, passwordC.text),
                  child: Container(
                    height: 60,
                    width: 239,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue),
                    child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.toDouble(),
                ),
                InkWell(
                      onTap: () => Get.to(Registrasi()),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
