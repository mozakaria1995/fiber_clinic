
import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/contactus_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';

class ContactUsRepo extends BaseRepo {

  //TODO
  Future<ContactModel?> contactUsRequest() {
    return networkManager
        .get<ContactModel>(Endpoints.CONTACT_US,);
  }

}
