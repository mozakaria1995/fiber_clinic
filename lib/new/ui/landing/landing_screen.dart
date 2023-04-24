import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/model/spicialties_response_model.dart';
import 'package:auth_manager/new/ui/drawer/drawer_screen.dart';
import 'package:auth_manager/new/ui/home/home_screen.dart';
import 'package:auth_manager/new/ui/landing/landing_bloc.dart';
import 'package:auth_manager/new/ui/previous_transactions/previous_transactions_screen.dart';
import 'package:auth_manager/new/ui/staff_list/staff_list_screen.dart';
import 'package:auth_manager/new/ui/videos/videos_screen.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../_profile/profile_screen.dart';
import '../../widgets/Custom_appBar_widget.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends BaseState<LandingScreen, LandingBloc> {
  @override
  void initBloc() {
    bloc = LandingBloc(this);
  }

  @override
  void initState() {
    super.initState();
    assignSpecialtiesList();
  }

  int tabIndex = 0;
  final titles = [
    "الرئيسية",
    "تعرف علي طاقمنا الطبي",
    "معاملاتي السابقة",
    "فيديوهات خاصة ب",
    "أخري"
  ];
  var items = [
    HomeScreen(),
    StaffListScreen(),
    const PreviousTransactionsScreen(),
    ProfileScreen(),
  ];
  List<Specialty>? specialtiesList = [];

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackGround,
      key: _key,
      appBar: CustomAppBar(
        title: titles[tabIndex],
        onDrawerIconClicked: () => _key.currentState!.openDrawer(),
        onSearchClicked: () {
          print("ss");
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 8),
        color: ColorManager.bottomNavBar,
        child:StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            style: TabStyle.reactCircle,
            backgroundColor: ColorManager.bottomNavBar,
            elevation: 0,
            curveSize: 100,
            height: 40,
            top: -20,

            items: [
              TabItem(icon: FontAwesomeIcons.clinicMedical, isIconBlend: true),
              TabItem(icon: FontAwesomeIcons.hospitalUser, isIconBlend: true),
              TabItem(icon: FontAwesomeIcons.fileMedicalAlt, isIconBlend: true),
              TabItem(icon: FontAwesomeIcons.video, isIconBlend: true),
              TabItem(
                  icon: FontAwesomeIcons.userEdit, isIconBlend: true),
            ],
            initialActiveIndex: tabIndex,
            onTap: (int i) => changeTabIndex(i),
          ),
        ),
      ),
      body: items[tabIndex],
      drawer: Drawer(
        child: CustomDrawer(specialtiesList: specialtiesList ?? []),
      ),
    );
  }

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  void assignSpecialtiesList() {
    bloc.getSpecialties();
    bloc.specialtiesController.stream.listen((event) {
      setState(() {
        specialtiesList = event?.specialtiesList ?? [];
        items.insert(3, VideosScreen(specialtiesList: specialtiesList));
      });
    });
  }
}
class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 5;

  @override
  double get iconSize => 20;


  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 20, color: color);
  }
}