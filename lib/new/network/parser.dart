import 'package:auth_manager/models/register_response_model.dart';
import 'package:auth_manager/new/model/Video_list_model.dart';
import 'package:auth_manager/new/model/all_prev_reservations_response.dart';
import 'package:auth_manager/new/model/article_list_model.dart';
import 'package:auth_manager/new/model/contactus_model.dart';
import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/model/my_reservations_model.dart';
import 'package:auth_manager/new/model/payment_url.dart';
import 'package:auth_manager/new/model/register_model.dart';
import 'package:auth_manager/new/model/reservation_response_model.dart';
import 'package:auth_manager/new/model/response/error_response.dart';
import 'package:auth_manager/models/login_response_model.dart';
import 'package:auth_manager/new/model/blog_model.dart';
import 'package:auth_manager/new/model/reservation_model.dart';
import 'package:auth_manager/new/model/spicialties_response_model.dart';
import 'package:auth_manager/new/model/staff_response.dart';
import 'package:auth_manager/new/model/sucess_response_model.dart';
import 'package:auth_manager/new/model/user_model.dart';

class Parser {
  static parse<T>(dynamic json) {
    switch (T) {
      case LoginResponseModel:
        return LoginResponseModel.successFromJson(json);
      case RegisterModel:
        return RegisterModel.fromJson(json);
      case RegisterResponseModel:
        return RegisterResponseModel.successfromJson(json);

      // reservations
      case ReservationsResponse:
        return ReservationsResponse.fromJson(json);
      case ReservationResponse:
        return ReservationResponse.fromJson(json);
      case ReservationModel:
        return ReservationModel.fromJson(json);

      //Blog
      case BlogsResponseModel:
        return BlogsResponseModel.fromJson(json);
      case BlogModel:
        return BlogModel.fromJson(json);
      case Links:
        return Links.fromJson(json);
      case Meta:
        return Meta.fromJson(json);
      case LinkModel:
        return LinkModel.fromJson(json);

      case UserDataModel:
        return UserDataModel.fromJson(json);
      case RegisterModel:
        return RegisterModel.fromJson(json);
      case RegisterResponseModel:
        return RegisterResponseModel.successfromJson(json);
      case ContactModel:
        return ContactModel.fromJson(json);
      case ErrorModel:
        return ErrorModel.fromJson(json);
      case PaymentUrl:
        return PaymentUrl.fromJson(json);
      case ReservationResponseModel:
        return ReservationResponseModel.fromJson(json);
      case MyReservationsModel:
        return MyReservationsModel.fromJson(json);
      case ClinicInfoModel:
        return ClinicInfoModel.fromJson(json);
      case ArticleListModel:
        return ArticleListModel.fromJson(json);

      case VideoListModel:
        return VideoListModel.fromJson(json);
      case SpecialtiesResponse:
        return SpecialtiesResponse.fromJson(json);
      case StaffResponse:
        return StaffResponse.fromJson(json);
      case StaffMember:
        return StaffMember.fromJson(json);
      case StaffMemberResponse:
        return StaffMemberResponse.fromJson(json);
      case AllPreviousReservationsResponse:
        return AllPreviousReservationsResponse.fromJson(json);
        case PreviousReservations:
        return PreviousReservations.fromJson(json);
      case SuccessResponse:
        return SuccessResponse.fromJson(json);
    }
  }
}
