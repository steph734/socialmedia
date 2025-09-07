import 'package:flutter/material.dart';
import 'package:socialmedia_clone/model/userdata.dart';
import 'package:socialmedia_clone/socialmedia.dart';

import 'register.dart';

// ignore: camel_case_types
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// ignore: camel_case_types
class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errormessage;
  late bool isError;

  @override
  void initState() {
    super.initState();
    errormessage = "";
    isError = false;
  }

  void checkLogin(username, password) {
    setState(() {
      if (username.isEmpty) {
        errormessage = "Please enter your username";
        isError = true;
      } else if (password.isEmpty) {
        errormessage = "Please enter your password";
        isError = true;
      } else {
        errormessage = "";
        isError = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Socialmedia(userdata: Userdata(), username: username),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Instagram style: clean background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Instagram logo placeholder
                const Text(
                  "Instagram",
                  style: TextStyle(
                    fontFamily: 'Billabong', // Instagram-like font if available
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),

                // Username field
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Phone number, username or email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Password field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Login button
                ElevatedButton(
                  onPressed: () {
                    checkLogin(
                      usernameController.text,
                      passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Error message
                if (isError)
                  Text(
                    errormessage,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                const SizedBox(height: 20),

                // Divider with OR
                Row(
                  children: [
                    const Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR"),
                    ),
                    const Expanded(
                      child: Divider(thickness: 1, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Register link at bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
