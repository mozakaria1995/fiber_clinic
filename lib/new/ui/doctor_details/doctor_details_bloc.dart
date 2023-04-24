import 'dart:async';
import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/contactus_model.dart';
import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/repositories/doctor_details_repo.dart';
import 'package:rxdart/rxdart.dart';

class DoctorDetailsBloc extends BaseBloc {
  DoctorDetailsBloc(BaseView view) : super(view);

  ClinicDetailsRepo doctorDetailsRepo = ClinicDetailsRepo();
  StreamController<StaffMemberResponse?> doctorDetailsController =  BehaviorSubject();
  void getDoctorInfo(String id) {
    doctorDetailsController.sink.add(null);
    doctorDetailsRepo.getStaffMemberById(id).then((response) {
      doctorDetailsController.sink.add(response);
    }, onError: (error) {
      handleError(error);
      if (!doctorDetailsController.isClosed) {
        doctorDetailsController.addError(error);
      }
    });
  }


  @override
  void onDispose() {
    doctorDetailsController.close();
    doctorDetailsRepo.dispose();
  }
}
