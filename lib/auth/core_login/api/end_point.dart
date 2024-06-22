class endPoint {
  static String BaseUrl = 'http://192.168.1.7:8000/api/v1/';
  static String signin = 'users/login';
  static String signup = 'users/signup';

  static String resetpassword = 'users/resetPassword/:token';
  static String updatemypassword = 'users/updateMyPassword';
  static String getUserDataEndPoint(id) {
    return "users/$id";
  }
}

class apikey {
  static String status = "statusCode";
  static String email = "email";
  static String name = "name";
  static String photo = "photo";
  static String password = "password";
  static String confrimpassword = "passwordConfirm";
  static String token = "token";
  static String message = "message";
  static String id = "id";
  static String reviews = "reviews";
}
