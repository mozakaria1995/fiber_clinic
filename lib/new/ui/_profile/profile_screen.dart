import 'dart:ffi';
import 'dart:io';

import 'package:auth_manager/models/reservation_model.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/ui/_profile/profile_bloc.dart';
import 'package:auth_manager/new/ui/login/login_screen.dart';
import 'package:auth_manager/new/ui/user_profile/user_profile_screen.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/appointment_card_widget.dart';
import 'package:auth_manager/new/widgets/list_tile_widget.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen, ProfileBloc> {
  List<Reservation>? myReservationsList;
  ReservationModel? selectedService;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSize.s14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TitleWidget(title: 'حجوزاتي'),
                SizedBox(height: FontSizeManager.s20),
                Container(
                  height: AppSize.s200,
                  child: StreamBuilder<MyReservationsModel?>(
                    stream: bloc.myReservationsController.stream,
                    builder: (context,
                        AsyncSnapshot<MyReservationsModel?> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!.reservationsList!.length > 0) {
                        myReservationsList = snapshot.data!.reservationsList!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: myReservationsList!.length,
                          itemBuilder: (context, index) => AppointmentCard(
                            isProfile: true,
                            reservationModel: myReservationsList![index],
                            onCancelClicked: () => openCancelConfirmationDialog(
                                myReservationsList![index].id!),
                          ),
                        );
                      } else if (snapshot.data?.reservationsList?.length == 0) {
                        return Container();
                      } else if (snapshot.hasError) {
                        return Center();
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(height: AppSize.s15),
                ProfileListTileItem(
                    icon: Icons.account_circle,
                    title: "الملف الشخصي",
                    onClicked: ()=>navigateTo(UserProfileScreen()) ),
                ProfileListTileItem(
                    icon: Icons.location_on,
                    title: "الموقع",
                    onClicked: openMap),
                ProfileListTileItem(
                    icon: FontAwesomeIcons.whatsapp,
                    title: "تواصل معنا عبر واتساب",
                    onClicked: openWhatsAppChat),
                ProfileListTileItem(
                    icon: FontAwesomeIcons.facebook,
                    title: "تواصل معنا عبر فيسبوك",
                    onClicked: openFacebook),
                ProfileListTileItem(
                    icon: Icons.person_add,
                    title: "دعوة صديق",
                    onClicked: shareApp),
                ProfileListTileItem(
                    icon: Icons.logout,
                    title: "تسجيل الخروج",
                    onClicked: () async {
                      await AppCache.instance.logout();
                      navigateToReplacement(LoginScreen());
                    }),
              ],
            ),
          )),
    );
  }

  @override
  void initBloc() async {
    bloc = ProfileBloc(this);
    bloc.getMyReservationsList();
  }

  void openCancelConfirmationDialog(int id) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            title: Text("حذف الموعد المحجوز"),
            content: Text("أنت علي وشك حذف الحجز ، هل تريد المتابعة ؟"),
            actions: [
              AppButton(
                  title: "لا",
                  onPressed: () => Navigator.of(context).pop(),
                  buttonColor: Colors.redAccent),
              SizedBox(height: 10),
              AppButton(
                  title: "نعم",
                  onPressed: () async {
                    if (await bloc.cancelReservation(id)) {
                      Navigator.of(context).pop();
                      setState(() {
                        myReservationsList!
                            .removeWhere((element) => element.id == id);
                      });
                      bloc.getReservationsByServiceId(
                          selectedService?.id! ?? 0);
                      showSuccessMsg("تم إلغاء الحجز بنجاح");
                    }
                  },
                  buttonColor: ColorManager.checkUpColor),
            ],
          ),
        );
        ;
      },
    );
  }
}

void openWhatsAppChat() async {
  String whatsAppNumber =
      AppCache.instance.getClinicInfo()?.data?.whatsapp ?? "";
  if (!whatsAppNumber.startsWith("+2")) {
    whatsAppNumber = "+2" + whatsAppNumber;
  }
  final whatsAppURlAndroid = "whatsapp://send?phone=$whatsAppNumber&text=";
  final whatAppURLIos = "https://wa.me/$whatsAppNumber?text=";
  if (Platform.isIOS) {
    await launchUrl(Uri.parse(whatAppURLIos));
  } else {
    await launchUrl(Uri.parse(whatsAppURlAndroid));
  }
}

void openFacebook() async {
  String? pageId =
      AppCache.instance.getClinicInfo()?.data?.faceBook ;

  String fbProtocolUrl= 'fb://profile/$pageId';

  String fallbackUrl = AppCache.instance.getClinicInfo()?.data?.faceBookCallbackURL??"";

  try {
    bool launched = await launchUrl(Uri.parse(fbProtocolUrl));

    if (!launched) {
      await launchUrl(Uri.parse(fallbackUrl));
    }
  } catch (e) {
    await launchUrl(Uri.parse(fallbackUrl));
  }
}

void openMap() async {
  String lat = AppCache.instance.getClinicInfo()?.data?.lat ?? "";
  String lng = AppCache.instance.getClinicInfo()?.data?.lng ?? "";

  final availableMaps = await MapLauncher.installedMaps;
  if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
    await MapLauncher.showMarker(
      mapType: MapType.google,
      coords: Coords(double.parse(lat), double.parse(lng)),
      title: "Fiber Clinic Location",
    );
  } else {
    await availableMaps.first.showMarker(
      coords: Coords(double.parse(lat), double.parse(lng)),
      title: "Fiber Clinic Location",

    );
  }
}

void shareApp() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String storeLink = "Now you can find ${packageInfo.appName} app \n";
  String? appleLink = AppCache.instance.getClinicInfo()?.data?.appleStoreLink ;
  String? googleLink = AppCache.instance.getClinicInfo()?.data?.googleStoreLink ;
  if ( googleLink != null) {
    storeLink = storeLink + "For Android : " + googleLink + "\n";
  }
  if ( appleLink != null) {
    storeLink = storeLink + "And For IOS : " + appleLink + "\n";
  }

  Share.share(storeLink);
}

