import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_cubit.dart';
import 'package:uberapp/modules/loginpage/cubit/login_page_cubit.dart';
import 'package:uberapp/modules/otppage/cubit/otp_cubit.dart';
import 'package:uberapp/shared/compontes/constants.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        var cubit = OtpCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textStyle(text: 'Phone verification'),
            textStyle(
                text: 'Enter your OTP Code below',
                fontWeight: FontWeight.bold,
                fontSize: 21),
            const SizedBox(
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
                    flex: 4,
                    child: TextFormField(
                      controller: cubit.codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24.0),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        counterText: "",
                        border: InputBorder.none,
                        hintText: "******",
                        hintStyle:
                            TextStyle(fontSize: 24.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        cubit.verifyOtp(cubit.codeController.text.toString(), LoginPageCubit.get(context).verId);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 20,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
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
                textAlign: TextAlign.start,
                text: TextSpan(
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                    children: [
                      TextSpan(text: 'Resend Code in '),
                      TextSpan(
                          text: '10 Seconds',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold))
                    ]))
          ]),
        );
      },
    );
  }
}
