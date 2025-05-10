import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/widgets/textFields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorsApp.loginBGColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 18),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 0),
                  height: 770,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple.shade700),
                    borderRadius: BorderRadius.circular(12),
                    color: ColorsApp.loginCardColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 38),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(
                            "Enter your details to create an account",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 21),
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        //* Name
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        normalField(
                            _nameController, Icons.person, "Enter your name"),

                        SizedBox(
                          height: 30,
                        ),

                        //* Email
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        normalField(
                            _emailController, Icons.email, "Enter your email"),

                        SizedBox(
                          height: 30,
                        ),

                        //* password
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade100)
                              ]),
                          height: 60,
                          child: TextField(
                            obscureText: !_isVisible,
                            style: TextStyle(
                                color: Colors.grey.shade200, fontSize: 22),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                                child: Icon(
                                   _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 26,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.password,
                                size: 26,
                                color: Colors.grey.shade200,
                              ),
                              label: Text(
                                "Enter your password",
                                style: TextStyle(
                                    color: Colors.grey.shade200, fontSize: 22),
                              ),
                              filled: true,
                              fillColor: ColorsApp.backgroundColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),

                        _isLoading
                            ? Center(
                                child: SpinKitCircle(
                                  color: Colors.purple.shade700,
                                  size: 30,
                                ),
                              )
                            : Center(
                                child: ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.create,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.purple.shade700),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        fixedSize: WidgetStatePropertyAll(
                                            Size(450, 55))),
                                    onPressed: () async {
                                      //* Register Function

                                      setState(() {
                                        _isLoading = true;
                                      });

                                      await Authservice.registerUser(
                                          context,
                                          _nameController.text.toString(),
                                          _emailController.text.toString(),
                                          _passwordController.text.toString());

                                      setState(() {
                                        _isLoading = false;
                                      });
                                    },
                                    label: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),

                        SizedBox(height: 30),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 22),
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromARGB(255, 184, 85, 226),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginPage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
