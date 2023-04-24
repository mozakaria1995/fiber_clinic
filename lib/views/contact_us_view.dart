import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/controllers/contact_us_controller.dart';
import 'package:auth_manager/models/contact_us_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  final ContactUsController contactUsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              SizedBox(
                height: 30,
              ),
              Center(
                child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[100],
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.jpeg"))),
                    )),
              ),
              Center(
                child: Text(
                  'Fiber Clinic',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: kTitleTextColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Divider(
                  thickness: 5,
                ),
              ),
              Obx(() {
                ContactUsModel? contactUsInfo =
                    contactUsController.contactUsInfo.value;

                if (contactUsInfo == null)
                  return Center(child: Text("No Info is provided"));
                return Column(
                  children: [
                    contactUsInfo.email != null
                        ? cardInfo(context, Icons.email, contactUsInfo.email!,
                            () async {
                            String? encodeQueryParameters(
                                Map<String, String> params) {
                              return params.entries
                                  .map((e) =>
                                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }

                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: contactUsInfo.email,
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Mobile APP Contact us'
                              }),
                            );

                            await launchUrl(emailLaunchUri);
                          })
                        : Container(),
                    contactUsInfo.phone != null
                        ? cardInfo(context, Icons.phone, contactUsInfo.phone!,
                            () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: "+2${contactUsInfo.phone}",
                            );
                            await launchUrl(launchUri);
                          })
                        : Container(),
                    contactUsInfo.locationUrl != null
                        ? cardInfo(context, Icons.share_location,
                            contactUsInfo.address!, () async {
                            Uri uri = Uri(
                                scheme: "https",
                                host: contactUsInfo.locationUrl);
                            await launchUrl(uri);
                          })
                        : Container(),
                    contactUsInfo.facebookUrl != null
                        ? cardInfo(context, Icons.facebook_outlined, "Facebook",
                            () async {
                            print(contactUsInfo.facebookUrl);

                            await launchUrl(
                                Uri.parse(
                                  contactUsInfo.facebookUrl!,
                                ),
                                mode: LaunchMode.inAppWebView);
                          })
                        : Container(),
                    contactUsInfo.whatsapp != null
                        ? cardInfo(context, Icons.eight_k, "Whatsapp",
                            () async {
                            Uri uri = Uri(
                                scheme: "https",
                                host: "wa.me",
                                path: "${contactUsInfo.whatsapp}");

                            await launchUrl(uri);
                          })
                        : Container(),
                  ],
                );
              })
            ]),
          ),
        ),
      ),
    );
  }

  Widget cardInfo(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 18,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
