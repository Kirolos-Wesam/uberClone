import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_cubit.dart';
import 'package:uberapp/modules/loginpage/cubit/login_page_cubit.dart';
import 'package:uberapp/modules/loginpage/cubit/login_page_state.dart';
import 'package:uberapp/shared/compontes/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      listener: (context, state) {
        if(state is VerificationSendSuccessState){
          LoginCubit.get(context).changeScreen(1);
        }
      },
      builder: (context, state) {
        var cubit = LoginPageCubit.get(context);
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () => cubit.countryPicker(context),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                child: cubit.countryCode.flagImage(),
                              ),
                            ),
                            textStyle(text: cubit.countryCode.dialCode),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 55,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: cubit.phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'ُEnter Your Mobile Number',
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
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
              SizedBox(height: 45,),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                    onPressed: () {
                      cubit.phoneAuth('${cubit.countryCode.dialCode}${cubit.phoneNumberController.text.toString()}');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(state is VerificationSendLoadingState)
                        CircularProgressIndicator()
                        else
                        textStyle(
                          text: 'Sign in',
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
