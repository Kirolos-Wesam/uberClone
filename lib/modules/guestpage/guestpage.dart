import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_cubit.dart';
import 'package:uberapp/modules/guestpage/cubit/guest_page_cubit.dart';
import 'package:uberapp/modules/guestpage/cubit/guest_page_state.dart';
import 'package:uberapp/modules/signupprofile/signupprofilepage.dart';
import 'package:uberapp/shared/compontes/constants.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestPageCubit, GuestPageState>(
      listener: (context, state) {
        if (state is VerificationSendSuccessState) {
          LoginCubit.get(context).changeScreen(1);
        }
        if (state is VerificationSendErrorState) {
          Fluttertoast.showToast(
              msg: "Something Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var cubit = GuestPageCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textStyle(text: 'Hello, Nice to meet you'),
              textStyle(
                  text: 'Get Ready With Uber Clone',
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    onPressed: () {
                      navigateTo(context, SignupProfilePage());
                    },
                    style: ElevatedButton.styleFrom(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is VerificationSendLoadingState)
                          CircularProgressIndicator(
                            color: Colors.white,
                          )
                        else
                          Text(
                            'Create Account',
                          ),
                      ],
                    )),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    onPressed: () {
                      LoginCubit.get(context).changeScreen(1);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is VerificationSendLoadingState)
                          CircularProgressIndicator(
                            color: Colors.white,
                          )
                        else
                          Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                      ],
                    )),
              ),
              SizedBox(height: 25,),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                            text: 'By creating in account you agree to our '),
                        TextSpan(
                            text: 'Terms Of Service ',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: 'and '),
                        TextSpan(
                            text: 'Privacy Policy ',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold))
                      ])),
              SizedBox(
                height: 45,
              ),
              // SizedBox(
              //   width: double.infinity,
              //   height: 55,
              //   child: ElevatedButton(
              //       onPressed: () {
              //         cubit.signInWithGoogle();
              //       },
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.grey[900]),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           if (state is VerificationSendLoadingState)
              //             CircularProgressIndicator(
              //               color: Colors.white,
              //             )
              //           else
              //             Text(
              //               'Sign In',
              //               style: TextStyle(color: Colors.white),
              //             ),
              //         ],
              //       )),
              // ),
            ],
          ),
        );
      },
    );
  }
}


