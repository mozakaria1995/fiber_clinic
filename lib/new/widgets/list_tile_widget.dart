import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:flutter/material.dart';

class ProfileListTileItem extends StatelessWidget {
  final String title;

  final IconData icon;

  final Function() onClicked;

  const ProfileListTileItem(
      {required this.title, required this.icon, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s16),
      child: ListTile(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeightManager.regular,
                fontSize: FontSizeManager.s14,
                fontFamily: FontManager.fontFamily,
                color: ColorManager.listTileColor),
          ),
        ),
        tileColor: Colors.white,
        trailing: Icon(icon),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8)),
        onTap: onClicked,
      ),
    );
  }
}
