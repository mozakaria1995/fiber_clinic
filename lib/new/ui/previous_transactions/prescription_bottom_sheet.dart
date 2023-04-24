import 'package:auth_manager/new/model/prescription_model.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/pdf_viewer.dart';
import 'package:auth_manager/new/widgets/priscription_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrescriptionBottomSheet extends StatelessWidget {
  final List<FileItem>? prescriptionList;
  final Function() onUploadFileTapped;
  final bool comesFromSendFile;

  const PrescriptionBottomSheet({
    required this.prescriptionList,
    required this.onUploadFileTapped,
    required this.comesFromSendFile,
  });

  @override
  Widget build(BuildContext context) {
    return prescriptionList!.length > 0
        ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          comesFromSendFile ? "الملفات الملحقة" : "الروشتات الملحقة",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 20),
        ),
        Expanded(
          child: ListView(
            children: prescriptionList!
                .map(
                  (prescription) => PrescriptionItem(
                onTap: () {
                  if (prescription.pdfUrl
                      ?.toLowerCase()
                      .endsWith(".pdf") ??
                      false)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PDFViewerFromAsset(
                            fromURL: true,
                            pdfAssetPath: prescription.pdfUrl ?? ""),
                      ),
                    );
                  else
                    launch(prescription.pdfUrl ?? "");
                },
                prescription: prescription,
                onDownloadTap: () {
                  launch(prescription.pdfUrl ?? "");
                },
              ),
            )
                .toList(),
          ),
        ),
        Visibility(
          visible: comesFromSendFile,
          child: Center(
            child: Container(
              height: 60,
              padding: const EdgeInsets.only(top: 10),
              child: AppButton(
                width: 200,
                height: 50,
                title: "رفع ملف",
                buttonColor: Colors.green,
                onPressed: onUploadFileTapped,
              ),
            ),
          ),
        )
      ],
    )
        : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            comesFromSendFile
                ? "لا يوجد ملفات ملحقة حتي الآن"
                : "لا يوجد روشتات ملحقة حتي الآن",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 20,
            ),
          ),
          Visibility(
            visible: comesFromSendFile,
            child: Center(
              child: Container(
                height: 60,
                padding: const EdgeInsets.only(top: 10),
                child: AppButton(
                  width: 200,
                  height: 50,
                  title: "رفع ملف",
                  buttonColor: Colors.green,
                  onPressed: onUploadFileTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
