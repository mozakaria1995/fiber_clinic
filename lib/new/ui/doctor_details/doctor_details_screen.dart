import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/ui/doctor_details/doctor_details_bloc.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/text_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/calender_container.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String doctorId;

  const DoctorDetailsScreen({required this.doctorId});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState
    extends BaseState<DoctorDetailsScreen, DoctorDetailsBloc> {
  late StaffMember doctorInfoModel;
  @override
  void initState() {
    super.initState();
    bloc.getDoctorInfo(widget.doctorId);
  }

  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorManager.scaffoldBackGround,
          shadowColor: Colors.transparent,
          title: Text("معلومات الطبيب",
              style: TextStyle(
                  color: ColorManager.primary,
                  fontFamily: FontManager.fontFamily,
                  fontWeight: FontWeightManager.semiBold,
                  fontSize: FontSizeManager.s16)),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<StaffMemberResponse?>(
              stream: bloc.doctorDetailsController.stream,
              builder: (context, AsyncSnapshot<StaffMemberResponse?> snapshot) {
                if (snapshot.hasData) {
                  doctorInfoModel = snapshot.data!.data!;
                  return Stack(
                    children: [
                      Container(
                        height: size.height,
                        width: size.width,
                        child: Center(
                          child: Image.asset(
                            "assets/images/background.png",
                            width: size.width,
                            height: size.height,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        color: ColorManager.primary.withOpacity(0.8),
                      ),
                      Positioned(
                        top: AppPadding.p50,
                        left: AppPadding.p0,
                        right: AppPadding.p0,
                        child: Container(
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: doctorInfoModel.image ?? "",
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                    imageBuilder: (context, imageProvider) => Center(
                                      child: CircleAvatar(
                                        backgroundImage: imageProvider,
                                        radius: 120,
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Center(
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.user,
                                            color: ColorManager.calenderGrey,
                                            size: 40,
                                          ),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  width: AppSize.s12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TitleWidget(
                                          color: ColorManager.white,
                                          title: doctorInfoModel.name ?? "",
                                          fontSize: FontSizeManager.s18),
                                      TitleWidget(
                                          color: ColorManager.white,
                                          title:
                                              doctorInfoModel.specialty ?? "",
                                          fontSize: FontSizeManager.s12,

                                      ),

                                      TitleWidget(
                                          color: ColorManager.white,
                                          title: doctorInfoModel.phone ?? "",
                                          fontSize: FontSizeManager.s12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: AppPadding.p200,
                        bottom: AppPadding.p0,
                        left: AppPadding.p0,
                        right: AppPadding.p0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.s60),
                            topRight: Radius.circular(AppSize.s60),
                          ),
                          child: Container(
                            color: ColorManager.white,
                            width: size.width,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: AppPadding.p20,
                                    left: AppPadding.p20,
                                    top: AppPadding.p20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   children: [
                                    //     Column(
                                    //       children: [
                                    //         TitleWidget(
                                    //           title: AppStrings.experience,
                                    //           fontSize: FontSizeManager.s14,
                                    //         ),
                                    //         SizedBox(
                                    //           height: AppSize.s8,
                                    //         ),
                                    //         TitleWidget(
                                    //           title: "١٥ سنة",
                                    //           color: ColorManager.subTextColor,
                                    //           fontSize: FontSizeManager.s20,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     Container(
                                    //       width: AppSize.s1_5,
                                    //       height: AppSize.s30,
                                    //       color: ColorManager.dividerColor,
                                    //     ),
                                    //     Column(
                                    //       children: [
                                    //         TitleWidget(
                                    //           title: AppStrings.patients,
                                    //           fontSize: FontSizeManager.s14,
                                    //         ),
                                    //         SizedBox(
                                    //           height: AppSize.s8,
                                    //         ),
                                    //         TitleWidget(
                                    //           title: "٢٠٠٠",
                                    //           color: ColorManager.subTextColor,
                                    //           fontSize: FontSizeManager.s20,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     Container(
                                    //       width: AppSize.s1_5,
                                    //       height: AppSize.s30,
                                    //       color: ColorManager.dividerColor,
                                    //     ),
                                    //     Column(
                                    //       children: [
                                    //         TitleWidget(
                                    //           title: AppStrings.procedures,
                                    //           fontSize: FontSizeManager.s14,
                                    //         ),
                                    //         SizedBox(
                                    //           height: AppSize.s8,
                                    //         ),
                                    //         TitleWidget(
                                    //           title: "٢٠١٠",
                                    //           color: ColorManager.subTextColor,
                                    //           fontSize: FontSizeManager.s20,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    const SizedBox(
                                      height: AppSize.s30,
                                    ),
                                    TitleWidget(
                                      title: AppStrings.biography,
                                      fontSize: FontSizeManager.s18,
                                      color: ColorManager.darkGreyColor,
                                    ),
                                    TitleWidget(
                                      title: doctorInfoModel.description ?? "",
                                      fontSize: FontSizeManager.s14,
                                      color: ColorManager.grey1,
                                    ),
                                    const SizedBox(
                                      height: AppSize.s10,
                                    ) /*,
                                    Table(
                                      border: TableBorder(
                                        top: BorderSide(),
                                        bottom: BorderSide(),
                                        left: BorderSide(),
                                        right: BorderSide(),
                                        horizontalInside: BorderSide(),
                                        verticalInside: BorderSide(),
                                      ),
                                      children: [
                                        _tableRow(dataList: [
                                          "اسم الطبيب",
                                          "التخصص",
                                          "رقم التليفون"
                                        ]),
                                        _tableRow(dataList: [
                                          doctorInfoModel.data!.drName!,
                                          doctorInfoModel.data!.specialty1 ??
                                              "specialty1",
                                          doctorInfoModel.data!.number1 ??
                                              "number1"
                                        ], color: ColorManager.black),
                                        _tableRow(dataList: [
                                          doctorInfoModel.data!.drName!,
                                          doctorInfoModel.data!.specialty2 ??
                                              "specialty2",
                                          doctorInfoModel.data!.number2 ??
                                              "number2"
                                        ], color: ColorManager.black),
                                        _tableRow(dataList: [
                                          doctorInfoModel.data!.drName!,
                                          doctorInfoModel.data!.specialty3 ??
                                              "specialty3",
                                          doctorInfoModel.data!.number3 ??
                                              "number3"
                                        ], color: ColorManager.black),
                                        _tableRow(dataList: [
                                          doctorInfoModel.data!.drName!,
                                          doctorInfoModel.data!.specialty4 ??
                                              "specialty3",
                                          doctorInfoModel.data!.number4 ??
                                              "number4"
                                        ], color: ColorManager.black),
                                      ],
                                    )*/
                                    ,
                                    const SizedBox(
                                      height: AppSize.s20,
                                    ),

                                    // TitleWidget(
                                    //   title: AppStrings.details,
                                    //   fontSize: FontSizeManager.s20,
                                    //   color: ColorManager.darkGreyColor,
                                    // ),
                                    // TitleWidget(
                                    //   title: AppStrings.lorem,
                                    //   fontSize: FontSizeManager.s14,
                                    //   color: ColorManager.grey1,
                                    // ),
                                    // const SizedBox(
                                    //   height: AppSize.s10,
                                    // ),
                                    // TitleWidget(
                                    //   title: AppStrings.schedule,
                                    //   fontSize: FontSizeManager.s20,
                                    //   color: ColorManager.darkGreyColor,
                                    // ),
                                    // SizedBox(
                                    //   width: double.infinity,
                                    //   height: AppSize.s100,
                                    //   child: ListView.builder(
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemBuilder: (context, i) {
                                    //       if (i % 2 == 0) {
                                    //         return Padding(
                                    //           padding:
                                    //               const EdgeInsets.all(8.0),
                                    //           child: CalenderContainer(
                                    //             width: AppSize.s40,
                                    //             height: AppSize.s80,
                                    //             color:
                                    //                 ColorManager.calenderGrey,
                                    //             textColor:
                                    //                 ColorManager.darkGreyColor,
                                    //             day: days[i],
                                    //             date: date[i],
                                    //           ),
                                    //         );
                                    //       } else {
                                    //         return Padding(
                                    //           padding:
                                    //               const EdgeInsets.all(8.0),
                                    //           child: CalenderContainer(
                                    //             width: AppSize.s40,
                                    //             height: AppSize.s80,
                                    //             color:
                                    //                 ColorManager.subTextColor,
                                    //             textColor: ColorManager.white,
                                    //             day: days[i],
                                    //             date: date[i],
                                    //           ),
                                    //         );
                                    //       }
                                    //     },
                                    //     itemCount: days.length,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  @override
  void initBloc() {
    // TODO: implement initBloc
    bloc = DoctorDetailsBloc(this);
  }

  TableRow _tableRow({required List<String> dataList, Color? color}) {
    return TableRow(
      children: dataList
          .map((item) => Padding(
                padding: EdgeInsets.all(AppPadding.p8),
                child: Center(
                    child: TitleWidget(
                  title: item,
                  color: color,
                  fontSize: FontSizeManager.s12,
                  textAlign: TextAlign.justify,
                )),
              ))
          .toList(),
    );
  }
}
