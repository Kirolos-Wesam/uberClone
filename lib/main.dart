// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uberapp/blocobserver.dart';
import 'package:uberapp/firebase_options.dart';
import 'package:uberapp/layouts/homescreen/cubit/home_cubit.dart';
import 'package:uberapp/layouts/homescreen/homescreen.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_cubit.dart';
import 'package:uberapp/layouts/loginscreen/loginscreen.dart';
import 'package:uberapp/modules/guestpage/cubit/guest_page_cubit.dart';
import 'package:uberapp/modules/login/cubit/login_form_cubit.dart';
import 'package:uberapp/modules/profilepage/cubit/profile_cubit.dart';
import 'package:uberapp/modules/profilepage/profilepage.dart';
import 'package:uberapp/modules/ridehistorypage/cubit/ride_history_cubit.dart';
import 'package:uberapp/modules/ridehistorypage/ridehistorypage.dart';
import 'package:uberapp/modules/settingpage/cubit/setting_page_cubit.dart';
import 'package:uberapp/modules/settingpage/settingpage.dart';
import 'package:uberapp/modules/signupprofile/cubit/signup_profile_cubit.dart';
import 'package:uberapp/modules/signupprofile/signupprofilepage.dart';
import 'package:uberapp/shared/compontes/constants.dart';
import 'package:uberapp/shared/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();

  Widget? widget;
  if(CacheHelper.getData(key: 'uId') != null){
    uId= CacheHelper.getData(key: 'uId');
    widget = HomeScreen();
  }
  else widget = LoginScreen(); 
  runApp(MyApp(widget: widget,));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget widget;

  MyApp({
    Key? key,
    required this.widget,
  }) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => LoginCubit())),
        BlocProvider(create: ((context) => HomeCubit()..getProfileData()..addMapStyle()..getCurrentLocation()..loadCustomMarker())),
        BlocProvider(create: (context) => GuestPageCubit()),
        BlocProvider(
          create: (context) => LoginFormCubit(),
        ),
        BlocProvider(
          create: (context) => SignupProfileCubit(),
        ),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => RideHistoryCubit()..getRides()),
        BlocProvider(create: (context) => SettingPageCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Uber Clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              useMaterial3: true,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
          home: widget,
        ),
      ),
    );
  }
}
