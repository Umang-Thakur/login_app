part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String phone_no;
  final String password;

  const LoginButtonPressed({@required this.phone_no, @required this.password});

  @override
  List<Object> get props => [phone_no, password];

  @override
  String toString() =>
      'LoginButtonPressed { phone_no : $phone_no , password : $password}';
}
