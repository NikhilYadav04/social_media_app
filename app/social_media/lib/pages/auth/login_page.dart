import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:social_media/pages/auth/register_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/widgets/logger_glob.dart';
import 'package:social_media/widgets/textFields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisible = false;
  bool _isLoading = false;

  void getDetails() async {
    final email = await LocalStorageFunctions.getEmail() ?? "";

    final name = await LocalStorageFunctions.getName() ?? "";

    final id = await LocalStorageFunctions.getUserID() ?? "";

    printLog("${email} ${name} ${id}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

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
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 18),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 50),
                  height: 640,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple.shade700),
                    borderRadius: BorderRadius.circular(12),
                    color: ColorsApp.loginCardColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back",
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
                            "Enter your details to login your account",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 21),
                          ),
                        ),
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
                                      Icons.login,
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
                                      //* Login API Call
                                      //* Register Function

                                      setState(() {
                                        _isLoading = true;
                                      });

                                      await Authservice.loginUser(
                                          context,
                                          _emailController.text.toString(),
                                          _passwordController.text.toString());

                                      setState(() {
                                        _isLoading = false;
                                      });
                                    },
                                    label: Text(
                                      "Login",
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
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RegisterPage(),
                                      ),
                                    );
                                  },
                                text: 'Register',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color.fromARGB(255, 184, 85, 226),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
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
