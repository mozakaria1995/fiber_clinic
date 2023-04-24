import 'package:auth_manager/new/utils/resoures/assets_manager.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  final Function() onDrawerIconClicked;
  final Function() onSearchClicked;
  const CustomAppBar({required this.title,
    required this.onDrawerIconClicked,
    required this.onSearchClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: FontSizeManager.s14,
          right: FontSizeManager.s14,
          top: FontSizeManager.s14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: onDrawerIconClicked,
                child: Image.asset(ImageAssets.drawerIcon ,
                  width:FontSizeManager.s20 ,
                height: FontSizeManager.s14,
                )),
            Text(title, style: TextStyle(color: ColorManager.primary,
                fontFamily: FontManager.fontFamily,
              fontWeight: FontWeightManager.semiBold,
              fontSize: FontSizeManager.s16
            ),),
            Container()
            // GestureDetector(
            //     onTap: onSearchClicked,
            //     child: Image.asset(ImageAssets.searchIcon ,
            //       width:FontSizeManager.s20 ,
            //       height: FontSizeManager.s14,
            //     ))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
