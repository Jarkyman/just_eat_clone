import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_eat_clone/base/custom_loader.dart';
import 'package:just_eat_clone/controllers/auth_controller.dart';
import 'package:just_eat_clone/models/sign_up_body_model.dart';
import 'package:just_eat_clone/routes/route_helper.dart';
import 'package:just_eat_clone/utils/colors.dart';
import 'package:just_eat_clone/utils/dimensions.dart';
import 'package:just_eat_clone/widgets/app_text_field.dart';
import 'package:just_eat_clone/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      't.png',
      'f.png',
      'g.png',
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Type in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Type in your phone number', title: 'Phone number');
      } else if (email.isEmpty) {
        showCustomSnackBar('Type in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Type in a valid email', title: 'Valid email');
      } else if (password.isEmpty) {
        showCustomSnackBar('Type in your password', title: 'Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password cant be less then 6 characters',
            title: 'Password');
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar('All went well', title: 'Perfect');
            Get.offNamed(RouteHelper.getInitial());
            print('Success registration');
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //LOGO
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage('assets/image/logo part 1.png'),
                          ),
                        ),
                      ),
                      //EMAIL
                      AppTextField(
                          textController: emailController,
                          hintText: 'Email',
                          icon: Icons.email),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //PASSWORD
                      AppTextField(
                          isObscure: true,
                          textController: passwordController,
                          hintText: 'Password',
                          icon: Icons.password_sharp),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //NAME
                      AppTextField(
                          textController: nameController,
                          hintText: 'Name',
                          icon: Icons.person),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //PHONE
                      AppTextField(
                          textController: phoneController,
                          hintText: 'Phone',
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //SIGN UP BUTTON
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              text: 'Sign up',
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      // TAG LINE
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: 'Have an account already?',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //SIGN UP OPTIONS
                      RichText(
                        text: TextSpan(
                          text: 'Sign up using on of the following methods',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimensions.radius30,
                              backgroundImage: AssetImage(
                                'assets/image/' + signUpImages[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
