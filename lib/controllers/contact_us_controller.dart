import 'package:auth_manager/models/contact_us_model.dart';
import 'package:auth_manager/services/contact_us_service.dart';
import 'package:get/state_manager.dart';

class ContactUsController extends GetxController {
  Rxn<ContactUsModel> contactUsInfo = Rxn<ContactUsModel>();

  @override
  void onInit() async {
    contactUsInfo.value = await ContactUsService().getContactUsInfo();
    super.onInit();
  }
}
