import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../controllers/sign_up_controller.dart';

class SignUpTwoView extends StatefulWidget {
  const SignUpTwoView({super.key});

  @override
  State<SignUpTwoView> createState() => _SignUpTwoViewState();
}

class _SignUpTwoViewState extends State<SignUpTwoView> {
  bool isChecked = false;

  SignUpController signupController = Get.put(SignUpController());

  final TextEditingController teamController = TextEditingController();
  final TextEditingController coachController = TextEditingController();
  final TextEditingController coachPhoneController = TextEditingController();
  final TextEditingController coachEmailController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController ncaaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Sign Up',
          style: h2.copyWith(
            color: AppColors.mainColor,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
              ),
              sh16,
              Divider(
                thickness: 1.3,
                color: AppColors.black,
                indent: Get.width * 0.35,
                endIndent: Get.width * 0.35,
              ),
              Text(
                'Registration',
                style: h4.copyWith(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              sh5,
              Text(
                '(2 of 2)',
                style: h4.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              sh16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Club team',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: teamController,
                    hintText: 'Enter your club team name',
                  ),
                  sh16,
                  Text(
                    'Club coach name',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: coachController,
                    hintText: 'Enter your club coach name',
                  ),
                  sh16,
                  Text(
                    'Club coach phone',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: coachPhoneController,
                    hintText: 'Enter your club coach phone number',
                   // keyboardType: TextInputType.phone,
                  ),
                  sh16,
                  Text(
                    'Club coach email',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: coachEmailController,
                    hintText: 'Enter your club coach email',
                    //keyboardType: TextInputType.emailAddress,
                  ),
                  sh16,
                  Text(
                    'Intended major',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: majorController,
                    hintText: 'Enter your intended major',
                  ),
                  sh16,
                  Text(
                    'NCAA eligibility number',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: ncaaController,
                    hintText: 'Enter your NCAA eligibility number',
                  ),
                  sh16,
                  Text(
                    'Email',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                   // keyboardType: TextInputType.emailAddress,
                  ),
                  sh16,
                  Text(
                    'Password',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    controller: passwordController,
                    hintText: '*************',
                    //obscureText: true,
                    sufIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          // Logic to toggle password visibility
                        });
                      },
                      child: Image.asset(
                        AppImages.eyeClose,
                        scale: 4,
                      ),
                    ),
                  ),
                  sh16,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Image.asset(
                          isChecked
                              ? AppImages.checkboxFilled
                              : AppImages.checkbox,
                          scale: 4,
                        ),
                      ),
                      sw12,
                      Expanded(
                        child: Text(
                          'By creating an account, I accept the Terms & Conditions & Privacy Policy.',
                          style: h5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              sh40,
              CustomButton(
                text: 'Sign Up',
                onPressed: () {
                  if (teamController.text.isEmpty ||
                      coachPhoneController.text.isEmpty ||
                      coachEmailController.text.isEmpty ||
                      majorController.text.isEmpty ||
                      ncaaController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      !isChecked) {
                    Get.snackbar('Error', 'Please fill all required fields and accept the terms.');
                    return;
                  }
                  String fcmToken = LocalStorage.getData(key: AppConstant.fcmToken);
                  signupController.signUp(
                    {
                      "club_team": teamController.text,
                      "club_coach_name": coachController.text,
                      "club_coach_phone": int.tryParse(coachPhoneController.text) ?? 0,
                      "club_coach_email": coachEmailController.text,
                      "intended_major": majorController.text,
                      "ncaa_eligibility_number": ncaaController.text,
                      "email": emailController.text,
                      "password": passwordController.text,
                      'fcm_token': fcmToken,
                    },
                  );
                },
              ),
              sh24,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account? ',
                    style: h5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignInView());
                    },
                    child: Text(
                      'Sign In',
                      style: h5.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
              sh30,
            ],
          ),
        ),
      ),
    );
  }
}
