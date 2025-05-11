import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';
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
              padding: EdgeInsets.symmetric(
                  horizontal: 2.232142 * SizeConfig.widthMultiplier),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.686799 * SizeConfig.heightMultiplier,
                      horizontal: 4.01785 * SizeConfig.widthMultiplier),
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 0),
                  height: 81.10957 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.purple.shade700),
                    borderRadius: BorderRadius.circular(
                        1.26404 * SizeConfig.heightMultiplier),
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
                              fontSize: 4.002810 * SizeConfig.heightMultiplier),
                        ),
                        SizedBox(
                          height: 1.053 * SizeConfig.heightMultiplier,
                        ),
                        FittedBox(
                          child: Text(
                            "Enter your details to create an account",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    2.212079 * SizeConfig.heightMultiplier),
                          ),
                        ),

                        SizedBox(
                          height: 3.1601134 * SizeConfig.heightMultiplier,
                        ),

                        //* Name
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    2.738765 * SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 1.580056 * SizeConfig.heightMultiplier,
                        ),
                        normalField(
                            _nameController, Icons.person, "Enter your name"),

                        SizedBox(
                          height: 3.1601134 * SizeConfig.heightMultiplier,
                        ),

                        //* Email
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    2.738765 * SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 1.5800567 * SizeConfig.heightMultiplier,
                        ),
                        normalField(
                            _emailController, Icons.email, "Enter your email"),

                        SizedBox(
                          height: 3.1601134 * SizeConfig.heightMultiplier,
                        ),

                        //* password
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    2.738765 * SizeConfig.heightMultiplier),
                          ),
                        ),
                        SizedBox(
                          height: 1.5800567 * SizeConfig.heightMultiplier,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  1.26404 * SizeConfig.heightMultiplier),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.grey.shade100)
                              ]),
                          height: 6.32022 * SizeConfig.heightMultiplier,
                          child: TextField(
                            obscureText: !_isVisible,
                            style: TextStyle(
                                color: Colors.grey.shade200,
                                fontSize:
                                    2.31741 * SizeConfig.heightMultiplier),
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
                                  size: 2.7387650 * SizeConfig.heightMultiplier,
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.password,
                                size: 2.7387650 * SizeConfig.heightMultiplier,
                                color: Colors.grey.shade200,
                              ),
                              label: Text(
                                "Enter your password",
                                style: TextStyle(
                                    color: Colors.grey.shade200,
                                    fontSize:
                                        2.317416 * SizeConfig.heightMultiplier),
                              ),
                              filled: true,
                              fillColor: ColorsApp.backgroundColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      1.264045 * SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    1.264045 * SizeConfig.heightMultiplier),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      1.264045 * SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 5.266855 * SizeConfig.heightMultiplier,
                        ),

                        _isLoading
                            ? Center(
                                child: SpinKitCircle(
                                  color: Colors.purple.shade700,
                                  size: 3.1601138 * SizeConfig.heightMultiplier,
                                ),
                              )
                            : Center(
                                child: ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.create,
                                      color: Colors.white,
                                      size: 3.792 * SizeConfig.heightMultiplier,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.purple.shade700),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1.053 *
                                                      SizeConfig
                                                          .heightMultiplier)),
                                        ),
                                        fixedSize: WidgetStatePropertyAll(Size(
                                            100.446 *
                                                SizeConfig.widthMultiplier,
                                            5.7935 *
                                                SizeConfig.heightMultiplier))),
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
                                          fontSize: 2.7387 *
                                              SizeConfig.heightMultiplier,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),

                        SizedBox(
                            height: 3.1601134 * SizeConfig.heightMultiplier),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    2.3174165 * SizeConfig.heightMultiplier),
                            children: [
                              TextSpan(text: "Already have an account? "),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  fontSize:
                                      2.3174165 * SizeConfig.heightMultiplier,
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
