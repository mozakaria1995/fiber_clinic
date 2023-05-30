import 'package:auth_manager/models/register_request_model.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/ui/landing/landing_screen.dart';
import 'package:auth_manager/new/ui/login/login_screen.dart';
import 'package:auth_manager/new/ui/register/register_bloc.dart';
import 'package:auth_manager/new/utils/resoures/assets_manager.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/text_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/utils/validator.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/input_form_field.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  final UserCredential? userCredential;
  final String? socialRegistrationType;

  const RegisterScreen(
      {Key? key, this.userCredential, this.socialRegistrationType})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterBloc> {
  GlobalKey<FormState> _textFormState = GlobalKey<FormState>();
  // TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String phoneNumber="";

  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obscureText = true;
  RegisterRequestModel registerRequestModel = RegisterRequestModel();

  @override
  void initState() {
    super.initState();
    setState(() {
      emailController.text = " ";
      emailController.text = widget.userCredential?.user?.email ?? " ";
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorManager.primary,
        body: Form(
          key: _textFormState,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Container(
                    child: Center(
                      child: Image.asset(
                        ImageAssets.appLogo,
                        width: AppSize.s100,
                        height: AppSize.s100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s75),
                            topRight: Radius.circular(AppSize.s75),
                          ),
                          child: Container(
                            color: ColorManager.white,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: AppPadding.p30,
                                  left: AppPadding.p30,
                                  top: AppPadding.p30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: TitleWidget(
                                        title: AppStrings.createAccount,
                                        fontSize: FontSizeManager.s26),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.firstNameTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                  Center(
                                    child: InputFieldWidget(
                                      textInputAction: TextInputAction.next,
                                      onchange: (val) {
                                        setState(() {
                                          firstNameController.isValidFullName();
                                        });
                                      },
                                      validation:
                                          firstNameController.isValidFullName(),
                                      validationText: "",
                                      width: size.width,
                                      lines: 1,
                                      controller: firstNameController,
                                      obscure: false,
                                      height: AppSize.s60,
                                      suffix: firstNameController
                                              .isValidFullName()
                                          ? Image.asset(
                                              "assets/images/check.png")
                                          : Image.asset(
                                              "assets/images/error-icon.png"),
                                    ),
                                  ),
                                  /*    const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.lastNameTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                  Center(
                                    child: InputFieldWidget(
                                      textInputAction: TextInputAction.next,
                                      onchange: (val) {
                                        setState(() {
                                          lastNameController.isValidName();
                                        });
                                      },
                                      validationText: "",
                                      validation:
                                          lastNameController.isValidName(),
                                      width: size.width,
                                      lines: 1,
                                      controller: lastNameController,
                                      obscure: false,
                                      height: AppSize.s60,
                                      suffix: lastNameController.isValidName()
                                          ? Image.asset(
                                              "assets/images/check.png")
                                          : Image.asset(
                                              "assets/images/error-icon.png"),
                                    ),
                                  ),*/
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.emailTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                  Center(
                                    child: InputFieldWidget(
                                      validationText: "",
                                      textInputAction: TextInputAction.next,

                                      onchange: (val) {
                                        setState(() {
                                          if(emailController.text.isEmpty){
                                            emailController.text = " ";
                                          }

                                        });
                                      },
                                      validation: true,
                                      width: size.width,
                                      lines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      obscure: false,
                                      height: AppSize.s60,
                                      // suffix: emailController.isValidEmail()
                                      //     ? Image.asset(
                                      //         "assets/images/check.png")
                                      //     : Image.asset(
                                      //         "assets/images/error-icon.png"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.mobileTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Center(
                                      child:  IntlPhoneField(
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
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.passwordTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                  Center(
                                    child: InputFieldWidget(
                                      validationText: "",
                                      isPassword:true,
                                      textInputAction: TextInputAction.next,
                                      onchange: (val) {
                                        setState(() {
                                          passwordController.text.isNotEmpty;
                                        });
                                      },
                                      validation:
                                      passwordController.text.isNotEmpty,
                                      width: size.width,
                                      lines: 1,
                                      controller: passwordController,
                                      obscure: true,
                                      height: AppSize.s60,
                                      suffix: passwordController.text.isNotEmpty
                                          ? Image.asset(
                                          "assets/images/check.png")
                                          : Image.asset(
                                          "assets/images/error-icon.png"),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  TitleWidget(
                                    title: AppStrings.confirmPasswordTitle,
                                  ),
                                  const SizedBox(
                                    height: AppSize.s14,
                                  ),
                                  Center(
                                    child: InputFieldWidget(
                                      isPassword:true,
                                      textInputAction: TextInputAction.next,
                                      onchange: (val) {
                                        setState(() {
                                          passwordConfirmationController
                                              .text.isNotEmpty;
                                        });
                                      },
                                      validation: passwordController.text ==
                                          passwordConfirmationController.text,
                                      validationText:
                                      AppStrings.inValidPassword,
                                      width: size.width,
                                      lines: 1,
                                      controller:
                                      passwordConfirmationController,
                                      obscure: true,
                                      height: AppSize.s60,
                                      suffix: (passwordController.text ==
                                          passwordConfirmationController
                                              .text)
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
                                          if (widget.userCredential == null) {
                                            if (await bloc.registerRequest(
                                                registerBody())) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          LandingScreen()));
                                            }
                                          } else {
                                            if (await bloc
                                                .socialRegisterRequest(
                                                    socialRegisterBody())) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          LandingScreen()));
                                            }
                                          }
                                        }
                                      },
                                      title: AppStrings.signUp,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s40,
                                  ),
                                  Center(
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: AppStrings.signinQuestion,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                                      TextSpan(
                                          text: AppStrings.signIn,
                                          recognizer: TapGestureRecognizer()
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
                                    ])),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
    bloc = RegisterBloc(this);
  }

  @override
  void dispose() {
    // phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    bloc.onDispose();
    super.dispose();
  }

  Map<String, dynamic> registerBody() {
    Map<String, dynamic> body = {
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone": phoneNumber,
      "password": passwordController.text,
      "email": emailController.text,
      "password_confirmation": passwordConfirmationController.text,
      "fcm_token": AppCache.instance.getStringForKey(AppCache.fcmToken),
    };

    return body;
  }

  Map<String, dynamic> socialRegisterBody() {
    Map<String, dynamic> body = {
      "social_id": widget.userCredential!.user!.uid,
      "email": widget.userCredential?.user?.email ?? "",
      "social_type": widget.socialRegistrationType,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone": phoneNumber,
      "password": passwordController.text,
      "password_confirmation": passwordConfirmationController.text,
      "fcm_token": AppCache.instance.getStringForKey(AppCache.fcmToken),
    };

    return body;
  }
}
