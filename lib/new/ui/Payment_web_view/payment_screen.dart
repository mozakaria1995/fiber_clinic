import 'dart:io';

import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/model/reservation_request_model.dart';
import 'package:auth_manager/new/ui/Payment_web_view/payment_bloc.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../repositories/reservation_repo.dart';

class PaymentScreen extends StatefulWidget {
  final ReservationRequestModel requestModel  ;
  const PaymentScreen({required this.requestModel}) ;
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends BaseState<PaymentScreen,PaymentBloc> {

  WebViewController controller= WebViewController();
  bool shouldShow = true ;



  @override
  Widget buildWidget(BuildContext context) {

    controller..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))..
    setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String string) {
            if (string.contains("&success=true")) {
              showSuccessMsg("تمت عملية الدفع و الحجز بنجاح");
              Navigator.pop(context);
            }
          },
          onPageFinished: (String){
            setState(() {
              shouldShow=false;

            });
          }


        )
    ) ..loadRequest(Uri.parse(url));

    return Scaffold(
        backgroundColor: ColorManager.scaffoldBackGround,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.scaffoldBackGround,
        shadowColor: Colors.transparent,
        title: Text("معلومات عملية الدفع",
            style: TextStyle(
                color: ColorManager.primary,
                fontFamily: FontManager.fontFamily,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSizeManager.s16)),
      ),
      body: Builder(


        builder: (context) {
          print("ziko"+url);

          if (shouldShow==false) {


            return WebViewWidget(
              controller: controller,


            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

  @override
  void initBloc() {
    bloc = PaymentBloc(this);
  }


}
