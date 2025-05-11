import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:social_media/pages/auth/register_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 2.2321*SizeConfig.widthMultiplier),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.symmetric(vertical: 3.6868*SizeConfig.heightMultiplier, horizontal: 4.01788*SizeConfig.widthMultiplier),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5.26685*SizeConfig.heightMultiplier),
                  height: 67.415754*SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple.shade700),
                    borderRadius: BorderRadius.circular(1.26404*SizeConfig.heightMultiplier),
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
                              fontSize: 4.002810*SizeConfig.heightMultiplier),
                        ),
                        SizedBox(
                          height: 1.0533*SizeConfig.heightMultiplier,
                        ),
                        FittedBox(
                          child: Text(
                            "Enter your details to login your account",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 2.212079*SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 3.160123*SizeConfig.heightMultiplier,
                        ),

                        //* Email
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 2.738765*SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 1.580056*SizeConfig.heightMultiplier,
                        ),
                        normalField(
                            _emailController, Icons.email, "Enter your email"),

                        SizedBox(
                          height: 3.160123*SizeConfig.heightMultiplier,
                        ),

                        //* password
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 2.73876*SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 1.58005*SizeConfig.heightMultiplier,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.26404*SizeConfig.heightMultiplier),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade100)
                              ]),
                          height: 6.320246*SizeConfig.heightMultiplier,
                          child: TextField(
                            obscureText: !_isVisible,
                            style: TextStyle(
                                color: Colors.grey.shade200, fontSize: 2.317416*SizeConfig.heightMultiplier),
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
                                  size: 2.73877*SizeConfig.heightMultiplier,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.password,
                                size: 2.73877*SizeConfig.heightMultiplier,
                                color: Colors.grey.shade200,
                              ),
                              label: Text(
                                "Enter your password",
                                style: TextStyle(
                                    color: Colors.grey.shade200, fontSize: 2.317416*SizeConfig.heightMultiplier),
                              ),
                              filled: true,
                              fillColor: ColorsApp.backgroundColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 5.2668*SizeConfig.heightMultiplier,
                        ),

                        _isLoading
                            ? Center(
                                child: SpinKitCircle(
                                  color: Colors.purple.shade700,
                                  size: 3.160123*SizeConfig.heightMultiplier,
                                ),
                              )
                            : Center(
                                child: ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.login,
                                      color: Colors.white,
                                      size: 3.79214*SizeConfig.heightMultiplier,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.purple.shade700),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1.0533*SizeConfig.heightMultiplier)),
                                        ),
                                        fixedSize: WidgetStatePropertyAll(
                                            Size(100.446*SizeConfig.widthMultiplier,5.793559*SizeConfig.heightMultiplier))),
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
                                          fontSize: 2.73876*SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),

                        SizedBox(height: 3.16011*SizeConfig.heightMultiplier),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.white, fontSize: 2.317416*SizeConfig.heightMultiplier),
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
                                  fontSize: 2.317416*SizeConfig.heightMultiplier,
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
