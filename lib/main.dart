import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/auth_bloc/authentication_bloc.dart';
import 'package:kinoverse/business_logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:kinoverse/business_logic/cubit/talent_fav_cubit/talent_fav_cubit.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/hire/home_page/home_page.dart';
import 'package:kinoverse/page/worker/landing_page/landing_page.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthenticationBloc()
              ..add(
                AuthAppStartedEvent(),
              )),
        BlocProvider(create: (context) => LogoutCubit()),
        BlocProvider(
          create: (context) => TalentFavCubit(),
          lazy: true,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  MyAppRoutes _appRoutes = MyAppRoutes();

  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: App.font1,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRoutes.onGenerateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticateUser) {
            return HireHomePage();
          }
          return LandingPage();
        }),
      ),
    );
  }
}
