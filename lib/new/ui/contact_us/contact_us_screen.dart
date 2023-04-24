import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/model/contactus_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_us_bloc.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends BaseState<ContactUsScreen, ContactUsBloc> {

  @override
  void initState() {
    super.initState();
    bloc.getContacts();
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

  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
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

              StreamBuilder<ContactModel?>(
                  stream: bloc.contactUsController.stream.asBroadcastStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data!.data!.email);
                      return Column(
                        children: [
                          snapshot.data!.data!.email != null
                              ? cardInfo(
                              context, Icons.email, snapshot.data!.data!.email!,
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
                                  path: snapshot.data!.data!.email,
                                  query: encodeQueryParameters(<String,
                                      String>{
                                    'subject': 'Mobile APP Contact us'
                                  }),
                                );

                                await launchUrl(emailLaunchUri);
                              })
                              : Container(),
                          snapshot.data!.data!.phone != null
                              ? cardInfo(
                              context, Icons.phone, snapshot.data!.data!.phone!,
                                  () async {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: "+2${snapshot.data!.data!.phone}",
                                );
                                await launchUrl(launchUri);
                              })
                              : Container(),
                          snapshot.data!.data!.googleMapLocationUrl != null
                              ? cardInfo(context, Icons.share_location,
                              snapshot.data!.data!.address!, () async {
                                Uri uri = Uri(
                                    scheme: "https",
                                    host: snapshot.data!.data!.googleMapLocationUrl);
                                await launchUrl(uri);
                              })
                              : Container(),
                          snapshot.data!.data!.facebook != null
                              ? cardInfo(context, Icons.facebook_outlined,
                              "Facebook", () async {
                                print(snapshot.data!.data!.facebook);
                                // Uri uri = Uri(
                                //   scheme: "https",
                                //   host: snapshot.data!.data!.facebook,
                                // );

                                await launchUrl(
                                    Uri.parse(
                                      snapshot.data!.data!.facebook!,
                                    ),
                                    mode: LaunchMode.inAppWebView);
                              })
                              : Container(),
                          snapshot.data!.data!.whatsapp != null
                              ? cardInfo(context, Icons.eight_k, "Whatsapp",
                                  () async {
                                Uri uri = Uri(
                                    scheme: "https",
                                    host: "wa.me",
                                    path: "${snapshot.data!.data!.whatsapp}");

                                await launchUrl(uri);
                              })
                              : Container(),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })

            ]),
          ),
        ),
      ),
    );
  }

  @override
  void initBloc() {
    bloc = ContactUsBloc(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.onDispose();
    super.dispose();
  }
}
