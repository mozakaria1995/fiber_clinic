import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/config/theme_helper.dart';
import 'package:auth_manager/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ChangePasswordView extends StatelessWidget {
  double _headerHeight = 250;

  final GlobalKey<FormState> formKey = GlobalKey();
  LoginController loginController = Get.put(LoginController());

  TextEditingController passwordCtr = TextEditingController();
  TextEditingController newPasswordCtr = TextEditingController();
  TextEditingController newPasswordConfirmationCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Form changePasswordForm() {
      return Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: passwordCtr,
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Please Enter Your Password'
                        : null;
                  },
                  obscureText: true,
                  decoration:
                      ThemeHelper().textInputDecoration('Current Password', ""),
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
              SizedBox(height: 30.0),
              Container(
                child: TextFormField(
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Please Enter New Password'
                        : null;
                  },
                  controller: newPasswordCtr,
                  obscureText: true,
                  decoration: ThemeHelper().textInputDecoration(
                    'New Password',
                    "",
                  ),
                ),
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
              ),
              SizedBox(height: 30.0),
              Container(
                child: TextFormField(
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Retype New Password'
                        : null;
                  },
                  controller: newPasswordConfirmationCtr,
                  obscureText: true,
                  decoration: ThemeHelper().textInputDecoration(
                    'Retype Password',
                    "",
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
                      'Save'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await loginController.changePassword(passwordCtr.text,
                          newPasswordCtr.text, newPasswordConfirmationCtr.text);
                    }
                  },
                ),
              ),
            ],
          ));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            LineAwesomeIcons.angle_left,
                            size: 30,
                          )),
                      SizedBox(height: 30.0),
                      Text(
                        'Change\nPassword',
                        style: TextStyle(
                            color: kTitleTextColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      changePasswordForm()
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
