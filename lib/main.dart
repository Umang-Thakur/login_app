import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_app/auth/auth.dart';
import 'package:login_app/bloc/authenticate_bloc.dart';
import 'package:login_app/model/cache_user.dart';
import 'package:login_app/ui/home.dart';
import 'package:login_app/ui/loading.dart';
import 'package:login_app/ui/login.dart';
import 'package:login_app/ui/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter<CacheUser>(CacheUserAdapter());
  // final userBox = await Hive.openBox<CacheUser>('CacheUser');
  runApp(App(authRepository: AuthRepository()));
}

class App extends StatefulWidget {
  final AuthRepository authRepository;
  // final Box<CacheUser> userBox;

  App({Key key, @required this.authRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;
  AuthRepository get authRepository => widget.authRepository;
  // Box<CacheUser> get userBox => widget.userBox;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(authRepository: authRepository);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitalized) {
              return SplashPage();
            }

            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }

            if (state is AuthenticationUnauthenticated) {
              return LoginPage(authRepository: authRepository);
            }

            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }

            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
