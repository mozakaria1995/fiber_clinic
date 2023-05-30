import 'dart:io';

import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/ui/forget_password/forget_password_screen.dart';
import 'package:auth_manager/new/ui/landing/landing_screen.dart';
import 'package:auth_manager/new/ui/register/register_screen.dart';
import 'package:auth_manager/new/utils/resoures/assets_manager.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/text_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/input_form_field.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auth_manager/new/utils/validator.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginBloc> {
  GlobalKey<FormState> _textFormState = GlobalKey<FormState>();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String phoneNumber="";
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
                            child: Image.asset(
                              ImageAssets.appLogo,
                              width: AppSize.s100,
                              height: AppSize.s100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: TitleWidget(
                                        title: AppStrings.signIn,
                                        fontSize: FontSizeManager.s26),
                                  ),
                                  TitleWidget(
                                    title: AppStrings.mobileTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s8,
                                  ),
                                  Center(
                                      child:Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: IntlPhoneField(
                                          invalidNumberMessage: "رقم غير صحيح",
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                          validator: (phoneNumber){

                                            if(phoneNumber!.number.isEmpty){

                                              return  "رقم غير صحيح";
                                            }else{

                                            }
                                          },
                                          initialCountryCode: 'EG',
                                          disableLengthCheck: true,

                                          onChanged: (phone) {
                                            phoneNumber=phone.number;
                                          },
                                        ),
                                      )

                                  ),
                                  const SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.passwordT,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s8,
                                  ),
                                  Center(
                                    child: InputFieldWidget(
                                      isPassword:true,

                                      onchange: (val) {
                                        setState(() {
                                          passwordController.text.isNotEmpty;
                                        });
                                      },
                                      validation: true,
                                      validationText: "",
                                      width: size.width,
                                      lines: 1,
                                      controller: passwordController,
                                      obscure: true,
                                      height: AppSize.s50,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s10,
                                  ),
                                  Center(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: AppStrings.forgetPassword,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          TextSpan(
                                              text: AppStrings
                                                  .forgetPasswordButton,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  setState(() {
                                                    // _formType = FormType.register;
                                                    navigateToReplacement(
                                                        ForgetPasswordScreen());
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
                                    height: AppSize.s10,
                                  ),
                                  Center(
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                              text: AppStrings.signUpQuestion,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          TextSpan(
                                              text: AppStrings.signUp,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  setState(() {
                                                    // _formType = FormType.register;
                                                    navigateToReplacement(
                                                        RegisterScreen());
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
                                    height: AppSize.s15,
                                  ),
                                  Center(
                                    child: AppButton(
                                      onPressed: () async {
                                        if (_textFormState.currentState!
                                            .validate()) {
                                          if (await bloc.requestLogin(
                                              phoneNumber,
                                              passwordController.text)) {
                                            navigateToReplacement(LandingScreen());
                                          }
                                        }
                                      },
                                      title: AppStrings.login,
                                      height: 50,
                                    ),
                                  ),
                                  Visibility(
                                      visible: AppCache.instance
                                                  .getStringForKey(
                                                      AppCache.phone) !=
                                              null &&
                                          AppCache.instance.getStringForKey(
                                                  AppCache.password) !=
                                              null,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: AppSize.s10,
                                          ),
                                          if(Platform.isAndroid)
                                          Center(
                                            child: AppButton(
                                              onPressed: () async {
                                                if (await bloc
                                                    .checkFingerPrintIfAvailable()) {
                                                  if (await bloc.requestLogin(
                                                      AppCache.instance
                                                          .getStringForKey(
                                                              AppCache.phone)!,
                                                      AppCache.instance
                                                          .getStringForKey(
                                                              AppCache
                                                                  .password)!)) {
                                                    navigateToReplacement(LandingScreen());
                                                  }
                                                }
                                              },
                                              title: AppStrings
                                                  .loginWithFingerPrint,
                                              height: 50,
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  Center(
                                      child: Column(
                                    children: [
                                      TitleWidget(
                                        title: AppStrings.signUpOptions,
                                        color: ColorManager.mainTextColor,
                                      ),
                                      const SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: () async {
                                              final userCredential =
                                                  await bloc.signInWithGoogle();
                                              if (await bloc
                                                  .requestSocialSignIn(
                                                      userCredential:
                                                          userCredential,
                                                      socialType: "google")) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            LandingScreen()));
                                              } else {
                                                navigateToReplacement(
                                                    RegisterScreen(
                                                  userCredential:
                                                      userCredential,
                                                  socialRegistrationType:
                                                      "google",
                                                ));
                                              }
                                            },
                                            child: CircleAvatar(
                                              radius: 20,
                                              child: Image.asset(
                                                ImageAssets.google,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          if (Platform.isIOS)
                                          const SizedBox(
                                            width: AppSize.s30,
                                          ),
                                          if (Platform.isIOS)
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.black,
                                            child: SignInButton(
                                                Buttons.AppleDark,
                                                mini: true,

                                                onPressed: () async {

                                                  final userCredential =
                                                  await bloc.signInWithApple();
                                                  if (await bloc
                                                      .requestSocialSignIn(
                                                      userCredential:
                                                      userCredential!,
                                                      socialType: "apple")) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                LandingScreen()));
                                                  } else {
                                                    navigateToReplacement(
                                                        RegisterScreen(
                                                          userCredential:
                                                          userCredential,
                                                          socialRegistrationType:
                                                          "apple",
                                                        ));
                                                  }

                                                }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
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
    bloc = LoginBloc(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // phoneController.dispose();
    passwordController.dispose();
    bloc.onDispose();
    super.dispose();
  }
}
