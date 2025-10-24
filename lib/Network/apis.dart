class Apis {
  // BASE URL
  // After you have entered/edited your base url, run the command:
  // flutter pub run build_runner build --delete-conflicting-outputs
  // to generate the api_services.g.dart file
  // Every time you change the base url, you need to run the above command
  static const String baseUrl = "https://voyzo.in/api/owner/";

  static const String apiConnectionTest = "apiConnectionTest";

  static const String login = "login";
  static const String register = "register";
  static const String verifyMe = "verifyMe";
  static const String forgot = "forgot";
  static const String newpassword = "newpassword";
  static const String home = "home";
  static const String category = "category";

  ///service
  static const String createService = "service";
  static const String displayService = "service";
  static const String singleService = "service/{id}";
  static const String updateService = "service/{id}";
  static const String deleteService = "service/{id}";

  ///packages
  static const String displayPackage = "package";
  static const String createPackage = "package";
  static const String singlePackage = "package/{id}";
  static const String updatePackage = "package/{id}";
  static const String deletePackage = "package/{id}";

  ///Employee
  static const String displayEmployee = "employee";
  static const String createEmployee = "employee";
  static const String singleEmployee = "employee/{id}";
  static const String updateEmployee = "employee/{id}";

  ///Notification
  static const String notification = "notification";

  ///Profile
  static const String profile = "profile";
  static const String profileUpdate = "profile/update";
  static const String profilePictureUpdate = "profile/picture/update";
  static const String profilePasswordUpdate = "profile/password/update";

  ///booking
  static const String booking = "booking";
  static const String singleBooking = "booking/{id}";
  static const String bookingApproved = "booking/{id}/approved";

  ///Shop
  static const String displayShop = "shop";
  static const String createShop = "shop";
  static const String singleShop = "shop/{id}";
  static const String updateShop = "shop/{id}";
}
