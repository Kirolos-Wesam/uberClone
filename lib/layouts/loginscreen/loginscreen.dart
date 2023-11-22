import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_cubit.dart';
import 'package:uberapp/layouts/loginscreen/cubit/login_state.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  padding:
                      const EdgeInsetsDirectional.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      color: Colors.grey[900]),
                  child: Stack(
                    children: [
                      if(cubit.index == 1)
                      Positioned(
                        top: 40,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            cubit.changeScreen(0);
                          },
                          child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Icon(Icons.arrow_back),
                                            ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/caricon.svg',
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Developed by Ecom-Eg',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                cubit.pages[1]
              ],
            ),
          ),
        );
      },
    );
  }
}
