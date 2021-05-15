import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/authenticate_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Text(
                    'Field',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    'Value',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ]),
                TableRow(children: [
                  Text('Username',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  Text(authenticationBloc.authRepository.user.user.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                ]),
                // TableRow(children: [
                //   Text('Password', textAlign: TextAlign.center),
                //   Text('Umang456', textAlign: TextAlign.center),
                // ]),
                TableRow(children: [
                  Text('Phone No',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  Text(authenticationBloc.authRepository.user.user.phone_no,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                ]),
                TableRow(children: [
                  Text('Referral Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  Text(
                      authenticationBloc.authRepository.user.user.referral_code,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                ]),
                // TableRow(children: [
                //   Text('Token', textAlign: TextAlign.center),
                //   Text('4f857e7829c6e78ad532c76ab6ae5fbb23fe6953',
                //       textAlign: TextAlign.center),
                // ]),
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(200),
            ),
            child: ElevatedButton(
              onPressed: () {
                authenticationBloc.add(LoggedOut());
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
        ])));
  }
}
