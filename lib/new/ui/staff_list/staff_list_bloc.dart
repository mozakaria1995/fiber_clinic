
import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/repositories/doctor_details_repo.dart';
import 'package:rxdart/rxdart.dart';

class StaffListBloc extends BaseBloc {
  StaffListBloc(BaseView view) : super(view);
  ClinicDetailsRepo doctorDetailsRepo = ClinicDetailsRepo();
  StreamController<List<StaffMember>?> staffListController =  BehaviorSubject();

  void getStaffList() {
    staffListController.sink.add(null);
    doctorDetailsRepo.getStaffList().then((response) {
      staffListController.sink.add(response!.staffList);
    }, onError: (error) {
      handleError(error);
      if (!staffListController.isClosed) {
        staffListController.addError(error);
      }
    });
  }

  @override
  void onDispose() {
    staffListController.close();
    doctorDetailsRepo.dispose();
  }

}