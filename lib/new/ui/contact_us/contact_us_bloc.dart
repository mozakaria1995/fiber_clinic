import 'dart:async';
import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/contactus_model.dart';
import 'package:auth_manager/new/repositories/contact_us_repo.dart';

class ContactUsBloc extends BaseBloc {
  ContactUsBloc(BaseView view) : super(view);

  ContactUsRepo contactUsRepo = ContactUsRepo();
  StreamController<ContactModel?> contactUsController = StreamController.broadcast();

  void getContacts() {
    contactUsController.add(null);
    contactUsRepo.contactUsRequest().then((response) {
      contactUsController.add(response);
    }, onError: (error) {
      handleError(error);
      if (!contactUsController.isClosed) {
        contactUsController.addError(error);
      }
    });
  }


  @override
  void onDispose() {
    contactUsController.close();
    contactUsRepo.dispose();
  }
}
