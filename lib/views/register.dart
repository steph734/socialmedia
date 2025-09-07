import 'package:flutter/material.dart';

import 'login.dart';

// ignore: camel_case_types
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

// ignore: camel_case_types
class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController changepasswordController =
      TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController civilstatusController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  late String errormessage;
  late bool isError;

  @override
  void initState() {
    super.initState();
    errormessage = "";
    isError = false;
  }

  void checkRegister(
    String name,
    String username,
    String password,
    String changepassword,
    String gender,
    String civilstatus,
    String birthdate,
  ) {
    setState(() {
      if (name.isEmpty) {
        errormessage = "Please input your name";
        isError = true;
      } else if (username.isEmpty) {
        errormessage = "Please input your username";
        isError = true;
      } else if (password.isEmpty) {
        errormessage = "Please input your password";
        isError = true;
      } else if (changepassword.isEmpty) {
        errormessage = "Please confirm your password";
        isError = true;
      } else if (password != changepassword) {
        errormessage = "Passwords do not match";
        isError = true;
      } else if (gender.isEmpty) {
        errormessage = "Please input your gender";
        isError = true;
      } else if (civilstatus.isEmpty) {
        errormessage = "Please input your civil status";
        isError = true;
      } else if (birthdate.isEmpty) {
        errormessage = "Please input your birthdate";
        isError = true;
      } else {
        errormessage = "";
        isError = false;

        // ✅ Registration success — you can add backend logic here
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")),
        );

        // Navigate back to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    });
  }

  Widget customTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Create Account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),

              // Name
              customTextField(
                controller: nameController,
                hint: "Full Name",
                icon: Icons.account_box,
              ),
              const SizedBox(height: 15),

              // Username
              customTextField(
                controller: usernameController,
                hint: "Username",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),

              // Password
              customTextField(
                controller: passwordController,
                hint: "Password",
                icon: Icons.lock,
                obscure: true,
              ),
              const SizedBox(height: 15),

              // Confirm Password
              customTextField(
                controller: changepasswordController,
                hint: "Confirm Password",
                icon: Icons.lock,
                obscure: true,
              ),
              const SizedBox(height: 15),

              // Gender
              customTextField(
                controller: genderController,
                hint: "Gender",
                icon: Icons.male,
              ),
              const SizedBox(height: 15),

              // Civil Status
              customTextField(
                controller: civilstatusController,
                hint: "Civil Status",
                icon: Icons.people,
              ),
              const SizedBox(height: 15),

              // Birthdate
              customTextField(
                controller: birthdateController,
                hint: "Birthdate",
                icon: Icons.date_range,
              ),
              const SizedBox(height: 25),

              // Error Message
              if (isError)
                Text(
                  errormessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const SizedBox(height: 15),

              // Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  checkRegister(
                    nameController.text,
                    usernameController.text,
                    passwordController.text,
                    changepasswordController.text,
                    genderController.text,
                    civilstatusController.text,
                    birthdateController.text,
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Back to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
