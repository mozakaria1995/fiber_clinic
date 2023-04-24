import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  var _title;
  //var _imageUrl;
  var _iconUrl;
  //var _bgColor;
  ServiceModel _service;

  CategoryCard(
      this._title, this._iconUrl, this._service);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed("/service-details", arguments: {"service": _service}),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            this._iconUrl != null
                ? Image.network(
                    _iconUrl,
                    width: 42,
                  )
                : Container(),
            SizedBox(
              height: 14,
            ),
            Text(
              _title,
              style: TextStyle(
                color: kTitleTextColor,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "${_service.price} EGP",
              // style: GoogleFonts.openSans(
              //     textStyle: TextStyle(
              //         color: Colors.white70,
              //         fontSize: 11,
              //         fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
