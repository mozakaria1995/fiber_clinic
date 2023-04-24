class Endpoints {
  static const BASE_URL = "https://amadoctors.com/api";
  // static const TEST_BASE_URL = "http://newv.amadoctors.com/api"
     // "https://demo.amadoctors.com/api"

  static const LOGIN_URL = "$BASE_URL/auth/login";
  static const SOCIAL_LOGIN_URL = "$BASE_URL/auth/social/login";
  static const SOCIAL_REGISTER_URL = "$BASE_URL/auth/social/register";
  static const REGISTER_URL = "$BASE_URL/auth/register";
  static const FORGET_PASSWORD_URL = "$BASE_URL/auth/password/email";
  static const UPDATE_PASSWORD_URL = "$BASE_URL/updatePassword";
  static const USER_PROFILE_URL = "$BASE_URL/me";
  static const UPDATE_PROFILE_USER = "$BASE_URL/updateProfile";
  static const UPDATE_PROFILE_PIC = "$BASE_URL/updateProfilePicture";

  // RESERVATIONS APIS
  static const RESERVATIONS = "$BASE_URL/reservationServices";

  static const SCHEDULED_RESERVATION = "$BASE_URL/reservationServices/";

  static const RESERVE_APPOINTMENT = "$BASE_URL/userReservations";

  static const GET_MY_RESERVATIONS = "$BASE_URL/get/user/reservations";

  static const CANCEL_RESERVATION = "$BASE_URL/reservation/";
  static const PREVIOUS_TRANSACTIONS = "$BASE_URL/get/user/allreservations";
  static const RATE_RESERVATION = "$BASE_URL/rateReservation";

  //upload prescription
  static const PRESCRIPTION_UPLOAD = "$BASE_URL/upload/reservation/file";

  // BLOGS
  static const BLOGS = "$BASE_URL/blogs";

  static const CONTACT_US = "$BASE_URL/contactUs";
  static const CLINIC_INFO = "$BASE_URL/clinic-info";
  static const STAFF_DETAILS = "$BASE_URL/staff/list";
  static const STAFF_MEMBER_DETAILS = "$BASE_URL/staff/details/";
  static const ARTICLE_LIST = "$BASE_URL/blogs";
  static const VIDEO_LIST = "$BASE_URL/videos";

  //Payment
  static const PAYMENT_KEY = "$BASE_URL/paymob/PaymentKey";

  //Specialties
  static const SPECIALTIES_RESPONSE = "$BASE_URL/blog_types";
}
