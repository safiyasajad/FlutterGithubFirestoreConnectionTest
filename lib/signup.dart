// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergithubfirestoreconnectiontest/login.dart';
import 'package:fluttergithubfirestoreconnectiontest/wrapper.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

    bool isPasswordHidden = true; //sets the password to be hidden

  signup()async{
      
    // Check if either field is empty.
    // If empty, show an error message and stop the function.
      if (email.text.isEmpty|| password.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter both email and password"),
            backgroundColor: Colors.red,
          ),
        );

        // return stops the function here.
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("sign up successful"),
          backgroundColor: Colors.green,
        ),
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Get.offAll(Login());
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up Page"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller:email, //telling code which filed to reference at
              decoration: InputDecoration(
                labelText:"Email",
                border: const OutlineInputBorder(),
                hintText: "Email") //the hint that is given in the email text field
            ),
            SizedBox(height:20,),
            TextField(
              controller: password, ///telling code which filed to reference at
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                labelText: "Password", //sets the title of the  box
                border: const OutlineInputBorder(),
                hintText: "Password", //the hint that is given in the password text field
                suffixIcon: IconButton( 
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  icon: Icon( //eye icon
                    isPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Column(
              
              children: [
                ElevatedButton(
                  onPressed: (() => signup()),
                  child: Text("Sign Up"),
                ),
                //distance between the signup button and the text 
                SizedBox(height: 20),

                //properties of the text displayed; already have an account 
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(Login());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}