import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberapp/layouts/homescreen/homescreen.dart';
import 'package:uberapp/modules/login/cubit/login_form_cubit.dart';
import 'package:uberapp/modules/profilepage/profilepage.dart';
import 'package:uberapp/shared/compontes/constants.dart';
import 'package:uberapp/shared/network/local/cache_helper.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFormCubit, LoginFormState>(
      listener: (context, state) {
        if (state is UserSignInSuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            navigateAndFinish(context, HomeScreen());
            uId = state.uId;
          });
        }
        if (state is UserRegisterState) {
          navigateAndFinish(context, ProfilePage());
        }
      },
      builder: (context, state) {
        var cubit = LoginFormCubit.get(context);
        return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textStyle(text: 'Create Your Account'),
                textStyle(
                    text: 'Get Ready With Uber Clone',
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            spreadRadius: 3,
                            blurRadius: 3)
                      ]),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            spreadRadius: 3,
                            blurRadius: 3)
                      ]),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: cubit.passwordController,
                      obscureText: cubit.isPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              icon: Icon(cubit.suffix)),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        cubit.userSignIn(email: cubit.emailController.text.toString(), password: cubit.passwordController.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[900]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(state is UserSignInLoadingState)
                          CircularProgressIndicator()
                          else
                          Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 55,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         cubit.signinWithGoogle();
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.red),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Sign In with Google',
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         ],
                //       )),
                // ),
              ],
            ));
      },
    );
  }
}
