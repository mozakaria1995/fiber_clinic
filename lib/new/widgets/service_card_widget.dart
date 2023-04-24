import 'dart:math';

import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
/*
class ServiceCard extends StatefulWidget {


  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  static  double minSize = 50 ;
   double width = minSize  ;

  @override
  void initState() {
    super.initState();
    if (widget.isSelected) {
        minSize = 100;
        width = minSize ;
    } else {
      minSize = 50;
      width = minSize ;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s10, right: AppSize.s10),
      child: GestureDetector(
        onTap: () {
          widget.onClicked();
          final size = generateSize();
          setState(() {
            this.width = size.width;
          });

        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInBack,
          width: width,
          height: width,
          child: Column(
            children: [
              Container(
                width: width,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorManager.grey2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s8),
                    topRight: Radius.circular(AppSize.s8),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    widget.serviceModel.title!,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontManager.fontFamily,
                        fontWeight: FontWeightManager.medium,
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: width,
                width: width,
                decoration: BoxDecoration(
                  color:
                      widget.isSelected ? ColorManager.grey2 : Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppSize.s8),
                    bottomRight: Radius.circular(AppSize.s8),
                  ),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Center(child: const CircularProgressIndicator()),
                  imageUrl: widget.serviceModel.photo ?? "",
                  fit: BoxFit.fill,

                  errorWidget: (context, url, error) =>
                      Center(child: const Icon(Icons.error)),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppSize.s8),
                        bottomRight: Radius.circular(AppSize.s8),
                      ),
                      image: DecorationImage(
                          /*colorFilter: ColorFilter.mode(
                              widget.isSelected
                                  ? ColorManager.primary.withOpacity(1)
                                  : Colors.white.withOpacity(0.3),
                              BlendMode.hardLight),*/
                          image: imageProvider,
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                // child: Stack(
                //   //mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     // SvgPicture.network(serviceModel.photo??"",),
                //     CachedNetworkImage(
                //       placeholder: (context, url) =>
                //           Center(child: const CircularProgressIndicator()),
                //       imageUrl: serviceModel.photo ?? "",
                //       fit: BoxFit.fill,
                //       errorWidget: (context, url, error) => Center(child: const Icon(Icons.error)),
                //       imageBuilder: (context, imageProvider) => Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8.0),
                //           image: DecorationImage(
                //               colorFilter: ColorFilter.mode(
                //                   isSelected
                //                       ? ColorManager.primary.withOpacity(1)
                //                       : Colors.white.withOpacity(0.3),
                //                   BlendMode.hardLight),
                //               image: imageProvider,
                //               fit: BoxFit.fill),
                //         ),
                //       ),
                //     ),
                //
                //     SizedBox(height: 10),
                //     Align(
                //       alignment: Alignment.bottomCenter,
                //       child: Padding(
                //         padding: const EdgeInsets.only(bottom: 10),
                //         child: Text(
                //           serviceModel.title!,
                //           overflow: TextOverflow.visible,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: isSelected
                //                 ? Colors.white
                //                 : ColorManager.serviceTitleColor,
                //             fontFamily: FontManager.fontFamily,
                //             fontWeight: FontWeightManager.medium,
                //             fontSize: 16
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Size generateSize() {

    if (widget.isSelected) {
      return Size(100 , 100 );
    } else {
      return Size(50 , 50);
    }
  }
}
*/
class ServiceCard extends StatelessWidget {
  final ReservationModel serviceModel;
  final bool isSelected;

  final Function() onClicked;

  ServiceCard(
      {required this.serviceModel,
        required this.onClicked,
        required this.isSelected});

  @override
  Widget build(BuildContext context) {
    double width = isSelected ? 150 : 120  ;
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s10, right: AppSize.s10),
      child: GestureDetector(
        onTap: onClicked,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInBack,
          width: width,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: ColorManager.bottomNavBar,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s8),
                    topRight: Radius.circular(AppSize.s8),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    serviceModel.title!,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontManager.fontFamily,
                        fontWeight: FontWeightManager.regular,
                        fontSize: 12),
                  ),
                ),
              ),
              Container(
                height: width,
                decoration: BoxDecoration(
                  color:
                 isSelected ? ColorManager.grey2 : Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppSize.s8),
                    bottomRight: Radius.circular(AppSize.s8),
                  ),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Center(child: const CircularProgressIndicator()),
                  imageUrl: serviceModel.photo ?? "",
                  fit: BoxFit.fill,

                  errorWidget: (context, url, error) =>
                      Center(child: const Icon(Icons.error)),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppSize.s8),
                        bottomRight: Radius.circular(AppSize.s8),
                      ),
                      image: DecorationImage(
                          image: imageProvider,

                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                // child: Stack(
                //   //mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     // SvgPicture.network(serviceModel.photo??"",),
                //     CachedNetworkImage(
                //       placeholder: (context, url) =>
                //           Center(child: const CircularProgressIndicator()),
                //       imageUrl: serviceModel.photo ?? "",
                //       fit: BoxFit.fill,
                //       errorWidget: (context, url, error) => Center(child: const Icon(Icons.error)),
                //       imageBuilder: (context, imageProvider) => Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8.0),
                //           image: DecorationImage(
                //               colorFilter: ColorFilter.mode(
                //                   isSelected
                //                       ? ColorManager.primary.withOpacity(1)
                //                       : Colors.white.withOpacity(0.3),
                //                   BlendMode.hardLight),
                //               image: imageProvider,
                //               fit: BoxFit.fill),
                //         ),
                //       ),
                //     ),
                //
                //     SizedBox(height: 10),
                //     Align(
                //       alignment: Alignment.bottomCenter,
                //       child: Padding(
                //         padding: const EdgeInsets.only(bottom: 10),
                //         child: Text(
                //           serviceModel.title!,
                //           overflow: TextOverflow.visible,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: isSelected
                //                 ? Colors.white
                //                 : ColorManager.serviceTitleColor,
                //             fontFamily: FontManager.fontFamily,
                //             fontWeight: FontWeightManager.medium,
                //             fontSize: 16
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
