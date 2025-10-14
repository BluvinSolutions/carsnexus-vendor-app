import 'package:carsnexus_owner/Authentication/model/forgot_response.dart';
import 'package:carsnexus_owner/Authentication/model/login_response.dart';
import 'package:carsnexus_owner/Authentication/model/register_response.dart';
import 'package:carsnexus_owner/Authentication/model/verify_me_response.dart';
import 'package:carsnexus_owner/Employee/Model/create_employee_response.dart';
import 'package:carsnexus_owner/Employee/Model/employees_response.dart';
import 'package:carsnexus_owner/Employee/Model/single_employee_profile_response.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/Model/create_shop_response.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/Model/home_model.dart';
import 'package:carsnexus_owner/Home%20&%20Shops/Model/shop_response.dart';
import 'package:carsnexus_owner/Network/api_connection_test_response_model.dart';
import 'package:carsnexus_owner/Network/apis.dart';
import 'package:carsnexus_owner/Package/Model/create_package_response.dart';
import 'package:carsnexus_owner/Package/Model/packages_response.dart';
import 'package:carsnexus_owner/Profile/Model/change_password_response.dart';
import 'package:carsnexus_owner/Profile/Model/notification_response.dart';
import 'package:carsnexus_owner/Profile/Model/profile_response.dart';
import 'package:carsnexus_owner/Service%20Request/Model/booking_approved_response.dart';
import 'package:carsnexus_owner/Service%20Request/Model/service_request_response.dart';
import 'package:carsnexus_owner/Service%20Request/Model/single_request_response.dart';
import 'package:carsnexus_owner/Services/Model/create_service_response.dart';
import 'package:carsnexus_owner/Services/Model/delete_response.dart';
import 'package:carsnexus_owner/Services/Model/services_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../Services/Model/category_response.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @POST(Apis.login)
  Future<LoginResponse> callLoginApi(@Body() body);

  @POST(Apis.register)
  Future<RegisterResponse> callRegisterApi(@Body() body);

  @POST(Apis.verifyMe)
  Future<VerifyMeResponse> callVerifyMe(@Body() body);

  @POST(Apis.forgot)
  Future<ForgotResponse> callForgotApi(@Body() body);

  @POST(Apis.newpassword)
  Future<LoginResponse> callSetNewPassword(@Body() body);

  @GET(Apis.home)
  Future<HomeModel> callHomeApi();

  @GET(Apis.category)
  Future<CategoryResponse> category();

  ///services

  @POST(Apis.createService)
  Future<CreateServiceResponse> createServices(@Body() body);

  @GET(Apis.displayService)
  Future<ServicesResponse> callAllService();

  @GET(Apis.singleService)
  Future<CreateServiceResponse> callSingleService(@Path() int id);

  @PUT(Apis.updateService)
  Future<CreateServiceResponse> callUpdateService(
    @Path() int id,
    @Field('cat_id') int catId,
    @Field('name') String name,
    @Field('price') num price,
    @Field('description') String description,
    @Field('status') int status,
  );

  @DELETE(Apis.deleteService)
  Future<DeleteResponse> callDeleteService(@Path() int id);

  ///packages

  @GET(Apis.displayPackage)
  Future<PackagesResponse> callGetPackages();

  @POST(Apis.createPackage)
  Future<CreatePackageResponse> callCreatePackage(@Body() body);

  @GET(Apis.singlePackage)
  Future<CreatePackageResponse> callSinglePackage(@Path() int id);

  @PUT(Apis.updatePackage)
  Future<CreatePackageResponse> callUpdatePackage(
    @Path() int id,
    @Field('service') String service,
    @Field('name') String name,
    @Field('price') num price,
    @Field('description') String description,
    @Field('status') int status,
    @Field('duration') num duration,
  );

  @DELETE(Apis.deletePackage)
  Future<DeleteResponse> callDeletePackage(@Path() int id);

  ///employee

  @GET(Apis.displayEmployee)
  Future<EmployeesResponse> callGetEmployee();

  @POST(Apis.createEmployee)
  Future<CreateEmployeeResponse> callCreateEmployee(@Body() body);

  @GET(Apis.singleEmployee)
  Future<SingleEmployeeProfileResponse> callSingleEmployee(@Path() int id);

  @PUT(Apis.updateEmployee)
  Future<CreateEmployeeResponse> callUpdateEmployee(
    @Path() int id,
    @Field("name") String name,
    @Field("phone_no") String phoneNumber,
    @Field("experience") String experience,
    @Field("id_no") String idNo,
    @Field("start_time") String startTime,
    @Field("end_time") String endTime,
    @Field('status') int status,
  );

  ///Notification
  @GET(Apis.notification)
  Future<NotificationResponse> callGetNotification();

  ///Profile
  @GET(Apis.profile)
  Future<ProfileResponse> callGetProfile();

  @POST(Apis.profileUpdate)
  Future<ProfileResponse> callUpdateProfile(@Body() body);

  @POST(Apis.profilePictureUpdate)
  Future<ProfileResponse> callUpdateProfilePicture(@Body() body);

  @POST(Apis.profilePasswordUpdate)
  Future<ChangePasswordResponse> callProfilePasswordUpdate(
      @Body() Map<String, dynamic> body);

  ///Booking
  @GET(Apis.booking)
  Future<ServiceRequestResponse> callGetBooking();

  @GET(Apis.singleBooking)
  Future<SingleRequestResponse> callSingleRequest(@Path() int id);

  @POST(Apis.bookingApproved)
  Future<BookingApprovedResponse> callUpdateBooking(
      @Path() int id, @Body() body);

  ///Shop
  @GET(Apis.displayShop)
  Future<ShopResponse> callGetShop();

  @POST(Apis.createShop)
  Future<CreateShopResponse> callCreateShop(@Body() body);

  @GET(Apis.singleShop)
  Future<CreateShopResponse> callSingleShop(@Path() int id);

  @PUT(Apis.updateShop)
  Future<CreateShopResponse> callUpdateShopWithPackage(
    @Path() int id,
    @Field("name") String name,
    @Field("address") String address,
    @Field("phone_no") String phoneNumber,
    @Field("start_time") String startTime,
    @Field("end_time") String endTime,
    @Field("service_id") String serviceId,
    @Field("package_id") String packageId,
    @Field("employee_id") String employeeId,
    @Field('status') int status,
    @Field('service_type') int serviceType,
  );

  @PUT(Apis.updateShop)
  Future<CreateShopResponse> callUpdateShopWithoutPackage(
    @Path() int id,
    @Field("name") String name,
    @Field("address") String address,
    @Field("phone_no") String phoneNumber,
    @Field("start_time") String startTime,
    @Field("end_time") String endTime,
    @Field("service_id") String serviceId,
    @Field("employee_id") String employeeId,
    @Field('status') int status,
    @Field('service_type') int serviceType,
  );

  @PUT(Apis.updateShop)
  Future<CreateShopResponse> callUpdateShopWithImagePackage(
    @Path() int id,
    @Field("name") String name,
    @Field("address") String address,
    @Field("phone_no") String phoneNumber,
    @Field("start_time") String startTime,
    @Field("end_time") String endTime,
    @Field("service_id") String serviceId,
    @Field("employee_id") String employeeId,
    @Field('status') int status,
    @Field('service_type') int serviceType,
    @Field('image') String image,
  );

  @GET(Apis.apiConnectionTest)
  Future<ApiConnectionTestResponse> apiConnectionTest();
}
