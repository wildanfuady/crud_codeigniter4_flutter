import 'package:flutter_crud_ci4/service/user_service.dart';

final UserApiService _siswaService = UserApiService();

class ApiService{
  
  static UserApiService get userService => _siswaService;

}