import 'package:auth_manager/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(
        title: _formType == FormType.login ? Text('Login') : Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: _formType == FormType.login ? loginForm() : registerForm(),
      ),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: phoneCtr,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Phone Number'
                : null;
          },
          decoration:
              inputDecoration('Phone number', Icons.phone, prefix: "+2"),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Password'
                : null;
          },
          controller: passwordCtr,
          decoration: inputDecoration('Password', Icons.lock),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              await _viewModel.loginUser(phoneCtr.text, passwordCtr.text);
            }
          },
          child: Text('Login'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _formType = FormType.register;
            });
          },
          child: Text('Does not have an account?'),
        )
      ]),
    );
  }

  Form registerForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
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
          decoration: inputDecoration('First Name', Icons.person),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
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
          decoration: inputDecoration('Last Name', Icons.person),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
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
          decoration: inputDecoration('Phone', Icons.phone, prefix: "+2"),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
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
          decoration: inputDecoration('Password', Icons.lock),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: passwordConfirmationCtr,
          validator: (value) {
            if ((value == null || value.isEmpty)) {
              return 'Please Retype Password';
            } else if (_viewModel.fieldErrors != null) {
              if (_viewModel.fieldErrors!
                  .containsKey('password_confirmation')) {
                return _viewModel.fieldErrors!['password_confirmation'][0];
              }
            } else {
              return null;
            }
          },
          decoration: inputDecoration('Retype Password', Icons.lock),
        ),
        ElevatedButton(
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
          child: Text('Register'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _formType = FormType.login;
            });
          },
          child: Text('Login'),
        )
      ]),
    );
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.grey),
    fillColor: Colors.grey.shade200,
    filled: true,
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    prefixIconConstraints: BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black)),
  );
}

enum FormType { login, register }
