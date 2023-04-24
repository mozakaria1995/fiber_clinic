
import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/ui/forget_password/forget_password_bloc.dart';
import 'package:auth_manager/new/ui/login/login_screen.dart';

import 'package:auth_manager/new/ui/register/register_screen.dart';
import 'package:auth_manager/new/utils/resoures/assets_manager.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/text_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/input_form_field.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auth_manager/new/utils/validator.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState
    extends BaseState<ForgetPasswordScreen, ForgetPasswordBloc> {
  GlobalKey<FormState> _textFormState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool obscureText = true;

  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.white,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
                  key: _textFormState,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          height: size.height / 2,
                          color: ColorManager.primary,
                        ),
                        SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              Container(
                                color: ColorManager.primary,
                                child: Center(
                                  child: Image.asset(ImageAssets.appLogo,
                                    width: AppSize.s100,
                                    height: AppSize.s100,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s30,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s60),
                                  topRight: Radius.circular(AppSize.s60),
                                ),
                                child: Container(
                                  color: ColorManager.white,
                                  width: size.width,
                                  //height: size.height -AppSize.s190,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: AppPadding.p40,
                                        left: AppPadding.p40,
                                        top: AppPadding.p30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: TitleWidget(
                                              title: AppStrings.forgetPassword,
                                              fontSize: FontSizeManager.s30),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s30,
                                        ),
                                        TitleWidget(
                                          title: AppStrings.forgetPasswordTitle,
                                        ),
                                        const SizedBox(
                                          height: AppSize.s14,
                                        ),
                                        Center(
                                          child: InputFieldWidget(
                                            onchange: (val) {
                                              setState(() {
                                                emailController.isValidEmail();
                                              });
                                            },
                                            validation:
                                                emailController.isValidEmail(),
                                            validationText: "",
                                            width: size.width,
                                            lines: 1,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: emailController,
                                            obscure: false,
                                            height: AppSize.s60,
                                            suffix: emailController
                                                    .isValidEmail()
                                                ? Image.asset(
                                                    "assets/images/check.png")
                                                : Image.asset(
                                                    "assets/images/error-icon.png"),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s60,
                                        ),
                                        Center(
                                          child: AppButton(
                                            onPressed: () async {
                                              if (_textFormState.currentState!
                                                  .validate()) {
                                                if (await bloc.forgetPassword(
                                                    emailController.text)) {
                                                  AwesomeDialog(
                                                      headerAnimationLoop: true,
                                                      context: context,
                                                      dialogType:
                                                          DialogType.SUCCES,
                                                      animType:
                                                          AnimType.BOTTOMSLIDE,
                                                      body: Text(
                                                        "تم الارسال إلي البريد الاليكتروني بنجاح",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1,
                                                      ),
                                                      buttonsTextStyle: Theme
                                                              .of(context)
                                                          .textTheme
                                                          .headline1!
                                                          .copyWith(
                                                              color:
                                                                  ColorManager
                                                                      .white),
                                                      btnOkText: 'رجوع',
                                                      btnOkColor:
                                                          ColorManager.primary,
                                                      btnOkOnPress: () {},
                                                      customHeader: Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        color: ColorManager
                                                            .checkColor,
                                                        size: 70,
                                                      )).show();
                                                } else {
                                                  showErrorMsg(
                                                      "حدث خطأ. بيانات غير صحيحة");
                                                }
                                              }
                                            },
                                            title: AppStrings.resetPassword,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s40,
                                        ),
                                        Center(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: AppStrings
                                                        .signinQuestion,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1),
                                                TextSpan(
                                                    text: AppStrings.signIn,
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            setState(() {
                                                              // _formType = FormType.register;
                                                              navigateToReplacement(
                                                                  LoginScreen());
                                                            });
                                                          },
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppSize.s20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

        ),
      ),
    );
  }

  @override
  void initBloc() {
    bloc = ForgetPasswordBloc(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    bloc.onDispose();
    super.dispose();
  }
}
