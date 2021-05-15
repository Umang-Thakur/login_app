import 'package:dio/dio.dart';
import 'package:login_app/model/user.dart';
import 'package:meta/meta.dart';

class AuthApiProvider {
  final String _endpoint =
      'http://ec2-3-108-41-128.ap-south-1.compute.amazonaws.com/auth/';
  Dio _dio;

  AuthApiProvider() {
    BaseOptions options = BaseOptions(
        baseUrl: _endpoint,
        headers: getHeaders(),
        receiveTimeout: 5000,
        connectTimeout: 5000);
    _dio = Dio(options);
  }

  getHeaders() {
    return {
      'Accept': '*/*',
      'Content-Type': 'form-data',
    };
  }

  String _handleError(dynamic error) {
    String errorDesciption = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDesciption = "Request to Api server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDesciption = "Connection limit Timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDesciption = "Receive Timeout in connection with API Server";
          break;
        case DioErrorType.response:
          errorDesciption = "Invalid Credentials";
          break;
        case DioErrorType.sendTimeout:
          errorDesciption = "Send timeout in connection with API server";
          break;
        case DioErrorType.other:
          errorDesciption = "Unknown Error";
          break;
      }
    }
    return errorDesciption;
  }

  Future<AuthResponse> getUser(String phone_no, String password) async {
    FormData formData =
        new FormData.fromMap({"phone_no": phone_no, "password": password});
    try {
      Response response = await _dio.post('/login/', data: formData);
      return AuthResponse.fromJson(response.data);
    } catch (error) {
      // print('Exception occured : $error stackTrace : $stacktrace');
      return AuthResponse.withError(_handleError(error));
    }
  }
}

class AuthRepository {
  AuthApiProvider _authApiProvider = AuthApiProvider();
  Authenticate user;

  Future<AuthResponse> getUser(String phone_no, String password) {
    return _authApiProvider.getUser(phone_no, password);
  }

  Future<String> authenticate({
    @required String phone_no,
    @required String password,
  }) async {
    AuthResponse response = await getUser(phone_no, password);
    if (response.error == "") {
      this.user = response.results;
      return this.user.token;
    }
    return throw response.error;
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<void> deleteToken(String token) async {
    await Future.delayed(Duration(seconds: 1));
    this.user = null;
    // return false;
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1));
    if (this.user == null) {
      return false;
    }
    return true;
  }
}
