import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/authenticate_bloc.dart';
import 'package:login_app/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm(
      {Key key, @required this.loginBloc, @required this.authenticationBloc})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final phone = TextEditingController();
  final password = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void _login() {
    _loginBloc
        .add(LoginButtonPressed(phone_no: phone.text, password: password.text));
  }

  void _forgot() {
    print('Forgot button Pressed');
  }

  void _signup() {
    print('SignUp button Pressed');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${state.error}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            Container(
              height: 190.0,
              width: 90.0,
              padding: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('assets/images/preloader_mp.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              child: TextFormField(
                controller: phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Phone',
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone)),
                maxLength: 10,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter Your Phone Number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
                obscureText: true,
              ),
            ),
            TextButton(
              onPressed: _forgot,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(200),
              ),
              child: ElevatedButton(
                onPressed: state is! LoginLoading ? _login : null,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Expanded(child: Container()),
            Container(
              height: 30,
              child: state is LoginLoading ? CircularProgressIndicator() : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New User ? '),
                TextButton(onPressed: _signup, child: Text('Create Account'))
              ],
            ),
            Expanded(child: Container()),
          ]),
        );
      },
    );
  }
}
