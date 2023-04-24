import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/ui/doctor_details/doctor_details_screen.dart';
import 'package:auth_manager/new/ui/staff_list/staff_list_bloc.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/staff_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StaffListScreen extends StatefulWidget {
  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends BaseState<StaffListScreen, StaffListBloc> {
  @override
  void initBloc() {
    bloc = StaffListBloc(this);
  }

  @override
  void initState() {
    super.initState();
    bloc.getStaffList();
  }

  late List<StaffMember>? staffList;

  @override
  Widget buildWidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StreamBuilder<List<StaffMember>?>(
          stream: bloc.staffListController.stream,
          builder: (context, AsyncSnapshot<List<StaffMember>?> snapshot) {
            if (snapshot.hasData) {
              staffList = snapshot.data!;
              return ListView(
                padding: EdgeInsets.symmetric(horizontal:AppSize.s8) ,
                children: [
                   SizedBox(
                    height: AppSize.s10,
                  ),
                  ...staffList!
                      .map((member) => StaffListTile(
                          member,
                          () => navigateTo(
                              DoctorDetailsScreen(doctorId: "${member.id}"))))
                      .toList()
                ],
              );
            } else if (snapshot.hasError) {
              return Center();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
