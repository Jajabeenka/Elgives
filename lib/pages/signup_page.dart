import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? fname;
  String? lname;

// RegExp: This is a class in Dart used for representing regular expressions.
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(password);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9F1010),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heading,
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFC107), // Yellow background color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        emailField,
                        passwordField,
                        firstNameField,
                        lastNameField,
                      ],
                    ),
                  ),
                  submitButton
                ],
              ),
            )),
      ),
    );
  }

  Widget get heading => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Use yellow text color from theme
          ),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: "Email",
            hintText: "juandelacruz09@gmail.com",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your email";
            } else if (!isValidEmail(value)) {
              return "Please enter a valid email format";
            }
            return null;
          },
        ),
      );

Widget get passwordField => Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: TextFormField(
    obscureText: true,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: "Password", // Use 'labelText' instead of 'label'
      hintText: "At least 6 characters",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black54),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    onSaved: (value) => setState(() => password = value),
    validator: (value) {
      if (value == null ||
          value.isEmpty ||
          value.length < 6 ||
          !isValidPassword(value)) {
        return "Password must be at least 6 characters and contain letters, numbers, and special characters.";
      }
      return null;
    },
  ),
);

Widget get firstNameField => Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: TextFormField(
    decoration: InputDecoration(
      labelText: "First Name",
      hintText: "Enter a valid First Name",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black54),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    onSaved: (value) => setState(() => fname = value),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "First Name cannot be empty";
      }
      return null;
    },
  ),
);

Widget get lastNameField => Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: TextFormField(
    decoration: InputDecoration(
      labelText: "Last Name",
      hintText: "Enter a Last Name",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black54),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    onSaved: (value) => setState(() => lname = value),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Last Name cannot be empty";
      }
      return null;
    },
  ),
);

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // separate provider file
          try {
            await context
                .read<UserAuthProvider>()
                .authService
                // modified
                .signUp(email!, password!, fname!, lname!);
          } catch (e) {
            // Handle sign-up errors
            _showSnackBar("Sign-up failed: $e");
          }
          // check if the widget hasn't been disposed of after an asynchronous action
          if (mounted) Navigator.pop(context);
        }
      },
      child: const Text("Sign Up"));
}
