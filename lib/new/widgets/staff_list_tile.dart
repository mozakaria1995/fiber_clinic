import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StaffListTile extends StatelessWidget {
  final StaffMember member;
  final Function() onTap;

  const StaffListTile(this.member, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s8),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          borderOnForeground: true,
          shape: StadiumBorder(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: member.image ?? "",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
                imageBuilder: (context, imageProvider) => Center(
                  child: CircleAvatar(
                    backgroundImage: imageProvider,
                    minRadius: 80,
                    maxRadius: 100,
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white38,
                    child: Icon(
                      FontAwesomeIcons.user,
                      color: ColorManager.grey1,
                      size: 40,
                    ),
                    minRadius: 80,
                    maxRadius: 100,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        member.name!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(member.description!, maxLines: 2),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
