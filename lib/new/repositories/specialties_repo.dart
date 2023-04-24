
import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/spicialties_response_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';

class SpecialtiesRepo extends BaseRepo {

  Future<SpecialtiesResponse?> getSpecialtiesList() {
    return networkManager.get<SpecialtiesResponse>(Endpoints.SPECIALTIES_RESPONSE);
  }
}