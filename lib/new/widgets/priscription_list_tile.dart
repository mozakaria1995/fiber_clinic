import 'package:auth_manager/new/model/prescription_model.dart';
import 'package:auth_manager/new/utils/extensions/arabic_number_extensions.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrescriptionItem extends StatelessWidget {
  final FileItem prescription;
  final Function() onTap;
  final Function() onDownloadTap;

  const PrescriptionItem(
      {required this.prescription,
      required this.onTap,
      required this.onDownloadTap});

  @override
  Widget build(BuildContext context) {
    DateTime? date = DateTime.tryParse(prescription.created ?? "");
    String year = formatDate(date!, [yyyy]);
    String dayInMonth = formatDate(date, [d]);
    String month = formatDate(date, [M]);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 4,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.filePdf,
                            color: Colors.blueAccent),
                        SizedBox(width: 10),
                        Text(
                          dayInMonth.toArabicDigits() +
                              " " +
                              month.toArabicMonth() +
                              " " +
                              year.toArabicDigits(),
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.grey1),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: onDownloadTap,
                      tooltip: "تحميل",
                      splashRadius: 40,
                      splashColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade100,
                      icon: Icon(
                        FontAwesomeIcons.download,
                        color: ColorManager.grey2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
