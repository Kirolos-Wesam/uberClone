import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberapp/blocobserver.dart';
import 'package:uberapp/firebase_options.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_cubit.dart';
import 'package:uberapp/layouts/loginscreen/loginscreen.dart';
import 'package:uberapp/modules/loginpage/cubit/login_page_cubit.dart';
import 'package:uberapp/modules/otppage/cubit/otp_cubit.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => LoginCubit())),
        BlocProvider(create: (context) => LoginPageCubit(),),
        BlocProvider(create: (context)=> OtpCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        ),
        home:  LoginScreen(),
      ),
    );
  }
}
