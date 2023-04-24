import 'package:auth_manager/config/theme_helper.dart';
import 'package:auth_manager/controllers/login_controller.dart';
import 'package:auth_manager/widgets/login_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;

  final GlobalKey<FormState> formKey = GlobalKey();
  LoginController _viewModel = Get.put(LoginController());

  TextEditingController firstNameCtr = TextEditingController();
  TextEditingController lastNameCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController passwordConfirmationCtr = TextEditingController();

  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _formType == FormType.login
                            ? 'Sign in into your account'
                            : 'Register',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      _formType == FormType.login ? loginForm() : registerForm()
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Form loginForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: phoneCtr,
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please Enter Phone Number'
                      : null;
                },
                decoration:
                    ThemeHelper().textInputDecoration('Phone number', "", "+2"),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 30.0),
            Container(
              child: TextFormField(
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please Enter Password'
                      : null;
                },
                controller: passwordCtr,
                decoration: ThemeHelper().textInputDecoration(
                  'Password',
                  "Enter Your Password",
                ),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 15.0),
            // Container(
            //   margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
            //   alignment: Alignment.topRight,
            //   child: GestureDetector(
            //     onTap: () async {

            //     },
            //     child: Text(
            //       "Forgot your password?",
            //       style: TextStyle(
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              decoration: ThemeHelper().buttonBoxDecoration(context),
              child: ElevatedButton(
                style: ThemeHelper().buttonStyle(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    'Sign In'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await _viewModel.loginUser(phoneCtr.text, passwordCtr.text);
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              //child: Text('Don\'t have an account? Create'),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "Don\'t have an account? "),
                TextSpan(
                  text: 'Create',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _formType = FormType.register;
                      });
                    },
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // ignore: deprecated_member_use
                      color: Theme.of(context).accentColor),
                ),
              ])),
            ),
          ],
        ));
  }

  Form registerForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: firstNameCtr,
                validator: (value) {
                  if ((value == null || value.isEmpty)) {
                    return 'Please Enter First Name';
                  } else if (_viewModel.fieldErrors != null) {
                    if (_viewModel.fieldErrors!.containsKey('first_name')) {
                      return _viewModel.fieldErrors!['first_name'][0];
                    }
                  } else {
                    return null;
                  }
                },
                decoration: ThemeHelper().textInputDecoration(
                  'First Name',
                  "Enter Your First Name",
                ),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 15.0),
            Container(
              child: TextFormField(
                controller: lastNameCtr,
                validator: (value) {
                  if ((value == null || value.isEmpty)) {
                    return 'Please Enter Last Name';
                  } else if (_viewModel.fieldErrors != null) {
                    if (_viewModel.fieldErrors!.containsKey('last_name')) {
                      return _viewModel.fieldErrors!['last_name'][0];
                    }
                  } else {
                    return null;
                  }
                },
                decoration: ThemeHelper().textInputDecoration(
                  'Last Name',
                  "Enter Your Last Name",
                ),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 15.0),
            Container(
              child: TextFormField(
                controller: phoneCtr,
                validator: (value) {
                  if ((value == null || value.isEmpty)) {
                    return 'Please Enter phone';
                  } else if (_viewModel.fieldErrors != null) {
                    if (_viewModel.fieldErrors!.containsKey('phone')) {
                      return _viewModel.fieldErrors!['phone'][0];
                    }
                  } else {
                    return null;
                  }
                },
                decoration: ThemeHelper().textInputDecoration(
                  'Phone Number',
                  "Enter Your Phone Number",
                ),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 15.0),
            Container(
              child: TextFormField(
                validator: (value) {
                  if ((value == null || value.isEmpty)) {
                    return 'Please Enter Password';
                  } else if (_viewModel.fieldErrors != null) {
                    if (_viewModel.fieldErrors!.containsKey('password')) {
                      return _viewModel.fieldErrors!['password'][0];
                    }
                  } else {
                    return null;
                  }
                },
                controller: passwordCtr,
                decoration: ThemeHelper().textInputDecoration(
                  'Password',
                  "Enter Password",
                ),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 15.0),
            Container(
              child: TextFormField(
                controller: passwordConfirmationCtr,
                validator: (value) {
                  if ((value == null || value.isEmpty)) {
                    return 'Please Retype Password';
                  } else if (_viewModel.fieldErrors != null) {
                    if (_viewModel.fieldErrors!
                        .containsKey('password_confirmation')) {
                      return _viewModel.fieldErrors!['password_confirmation']
                          [0];
                    }
                  } else {
                    return null;
                  }
                },
                decoration: ThemeHelper().textInputDecoration(
                  'Retype Password',
                  "Retype Password",
                ),
              ),
              decoration: ThemeHelper().inputBoxDecorationShaddow(),
            ),
            SizedBox(height: 15.0),
            Container(
              decoration: ThemeHelper().buttonBoxDecoration(context),
              child: ElevatedButton(
                style: ThemeHelper().buttonStyle(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    'Register'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  _viewModel.fieldErrors = null;
                  if (formKey.currentState?.validate() ?? false) {
                    await _viewModel.registerUser(
                        firstNameCtr.text,
                        lastNameCtr.text,
                        phoneCtr.text,
                        passwordCtr.text,
                        passwordConfirmationCtr.text);
                    formKey.currentState?.validate();
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              //child: Text('Don\'t have an account? Create'),
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "Have an account? "),
                TextSpan(
                  text: 'Login',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _formType = FormType.login;
                      });
                    },
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // ignore: deprecated_member_use
                      color: Theme.of(context).accentColor),
                ),
              ])),
            ),
          ],
        ));
  }
}

enum FormType { login, register }
