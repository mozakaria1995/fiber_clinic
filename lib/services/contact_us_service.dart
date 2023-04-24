import 'package:auth_manager/config/config.dart';
import 'package:auth_manager/models/contact_us_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../new/network/Endpoints.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class ContactUsService extends GetConnect {
  final String domainUrl = Endpoints.BASE_URL;

  Future<ContactUsModel?> getContactUsInfo() async {
    String url = domainUrl + "contactUs";
    final response = await get(url);

    if (response.statusCode == HttpStatus.ok) {
      var body = response.body;
      if (body['data'].isNotEmpty) {
        var data = body['data'];
        ContactUsModel contactUsInfo;
        contactUsInfo = ContactUsModel.successfromJson(data);
        return contactUsInfo;
      }
    }
    return null;
  }
}
