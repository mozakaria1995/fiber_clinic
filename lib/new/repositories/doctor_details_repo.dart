import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/network/Endpoints.dart';

class ClinicDetailsRepo extends BaseRepo {

  //TODO
  Future<ClinicInfoModel?> getClinicBasicInfo() {
    return networkManager
        .get<ClinicInfoModel>(Endpoints.CLINIC_INFO);
  }

  Future<StaffResponse?> getStaffList() {
    return networkManager
        .get<StaffResponse>(Endpoints.STAFF_DETAILS);
  }

  Future<StaffMemberResponse?> getStaffMemberById(String id) {
    return networkManager
        .get<StaffMemberResponse>("${Endpoints.STAFF_MEMBER_DETAILS}$id");
  }

}
