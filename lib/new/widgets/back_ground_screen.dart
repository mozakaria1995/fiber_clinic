import 'package:flutter/material.dart';

class BackGroundScreen extends StatelessWidget {
  final String backGroundScreenPath;
  final Widget child;
  const BackGroundScreen(
      {required this.backGroundScreenPath, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage(backGroundScreenPath), fit: BoxFit.fill)),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(child: child),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
