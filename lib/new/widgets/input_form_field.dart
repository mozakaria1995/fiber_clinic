import 'package:auth_manager/new/utils/colors.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/style_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  bool obscure;
  final bool? done;
  final double height;
  final double width;
  final int lines;
  final String? hintText;
  final Widget? suffix;
  final keyboardType;
  final textInputAction;
  final TextEditingController controller;
  bool isUnderLinedTextField = false;
  bool isPassword=false;


  final bool? validation;
  final String? validationText;
  final FocusNode? focusNode;
  dynamic onchange;
  dynamic onChangedCompleted;

  InputFieldWidget({
    Key? key,
    required this.obscure,
    required this.height,
    required this.width,
    required this.lines,
    required this.controller,
    this.isPassword=false,
    this.hintText,
    this.isUnderLinedTextField = false,
    this.suffix,
    this.textInputAction,
    this.focusNode,
    this.done,
    this.keyboardType,
    this.validation,
    this.validationText,
    this.onchange,
    this.onChangedCompleted,
  }) : super(key: key);

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
          textInputAction: widget.textInputAction,
          onChanged: widget.onchange,

          onEditingComplete: widget.onChangedCompleted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (widget.validation == false && widget.validation != null) {
              return widget.validationText;
            } else if (value!.isEmpty) {
              return widget.validationText;
            } else {
              return null;
            }
          },
          controller: widget.controller,
          maxLines: widget.lines,

          cursorColor: appBasicColor,
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
          obscureText: widget.obscure,
          keyboardType: widget.keyboardType,
          style: widget.isUnderLinedTextField ? Theme.of(context).textTheme.headline6: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            suffix: widget.suffix,
            hintText: widget.hintText,
            suffixIcon: widget.isPassword == true
                ? GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.obscure == false) {
                    widget.obscure = true;
                  } else {
                    widget.obscure = false;
                  }
                });
              },
              child: Icon(widget.obscure
                  ? Icons.visibility
                  : Icons.visibility_off),
            )
                : null,

            contentPadding:  EdgeInsets.only(
                right: widget.isUnderLinedTextField ? 0 : AppPadding.p30,
                left: AppPadding.p30,
                top: widget.isUnderLinedTextField ? AppPadding.p10 : AppPadding.p30,
                bottom: widget.isUnderLinedTextField ? AppPadding.p10 : 0
            ),
            // hint style
            hintStyle: widget.isUnderLinedTextField ? Theme.of(context).textTheme.headline6:regularStyle(color: ColorManager.grey1),

            // label style
            labelStyle: mediumStyle(color: ColorManager.lightGreyTextColor),
            // error style
            errorStyle: regularStyle(color: ColorManager.redColor, fontSize: 0),

            // enabled border
            enabledBorder: widget.isUnderLinedTextField
                ? UnderlineInputBorder()
                : OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.primary, width: AppSize.s1_5),
                borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.s28))),

            // focused border
            focusedBorder:widget.isUnderLinedTextField
                ? UnderlineInputBorder()
                : OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.validation == true
                        ? ColorManager.primary
                        : ColorManager.redColor,
                    width: AppSize.s1_5),
                borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.s28))),

            // error border
            errorBorder: widget.isUnderLinedTextField
                ? UnderlineInputBorder()
                :OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.validation == true
                        ? ColorManager.primary
                        : ColorManager.redColor, width: AppSize.s1_5),
                borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.s28))),
            // focused error border
            focusedErrorBorder:widget.isUnderLinedTextField
                ? UnderlineInputBorder()
                : OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorManager.primary, width: AppSize.s1_5),
                borderRadius:
                const BorderRadius.all(Radius.circular(AppSize.s28))),
          )),
    );
  }
}
