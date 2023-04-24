import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryCardItem extends StatelessWidget {
  final ReservationModel serviceModel;

  final Function onClicked;

  CategoryCardItem({required this.serviceModel, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CachedNetworkImage(
              
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: serviceModel.photo??"",
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(
              serviceModel.title!,
              style: TextStyle(color: kTitleTextColor),
            ),
            Text(
              "${serviceModel.price} EGP",
            ),
          ],
        ),
      ),
    );
  }
}
