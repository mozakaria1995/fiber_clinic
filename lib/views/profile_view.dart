
import 'package:auth_manager/controllers/login_controller.dart';
import 'package:auth_manager/core/authentication_manager.dart';
import 'package:auth_manager/widgets/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileView extends StatelessWidget {
  final LoginController loginController = Get.find();
  final AuthenticationManager authController = Get.find();

  @override
  Widget build(BuildContext context) {
    const kSpacingUnit = 8;
    ScreenUtil.init(context);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/images/doctor1.png'),
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     height: kSpacingUnit.w * 2.5,
                //     width: kSpacingUnit.w * 2.5,
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).accentColor,
                //       shape: BoxShape.circle,
                //     ),
                //     child: Center(
                //       heightFactor: kSpacingUnit.w * 1.5,
                //       widthFactor: kSpacingUnit.w * 1.5,
                //       child: Icon(
                //         LineAwesomeIcons.pen,
                //         // color: kDarkPrimaryColor,
                //         size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            authController.user.value!.firstName! +
                " " +
                authController.user.value!.lastName!,
            // style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            "+2" + authController.user.value!.phone!,
            // style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: kSpacingUnit.w * 5),
          header,
          Expanded(
            child: ListView(
              children: <Widget>[
                // ProfileListItem(
                //   icon: LineAwesomeIcons.user_shield,
                //   text: 'Privacy',
                // ),
                GestureDetector(
                  onTap: () => Get.toNamed("my-reservations"),
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.history,
                    text: 'My Reservations',
                  ),
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.question_circle,
                  text: 'Help & Support',
                ),
                // ProfileListItem(
                //   icon: LineAwesomeIcons.cog,
                //   text: 'Settings',
                // ),
                GestureDetector(
                  onTap: () => Get.toNamed("/change-password"),
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.user_lock,
                    text: 'Change Password',
                  ),
                ),
                GestureDetector(
                  onTap: () => loginController.logout(),
                  child: ProfileListItem(
                    icon: LineAwesomeIcons.alternate_sign_out,
                    text: 'Logout',
                    hasNavigation: false,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
