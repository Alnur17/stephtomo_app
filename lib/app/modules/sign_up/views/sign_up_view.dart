import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/sign_up/views/sign_up_two_view.dart';
import 'package:stephtomo_app/common/app_color/app_colors.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/size_box/custom_sizebox.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';
import 'package:stephtomo_app/common/widgets/custom_textfelid.dart';

import '../../../../common/app_text_style/styles.dart';
import '../../sign_in/views/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? handPreference;
  String? batPreference;
  String? throwPreference;
  String? selectedSport;

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
                '(1 of 2 )',
                style: h4.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              sh16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your name',
                  ),
                  sh16,
                  Text(
                    'Grad year',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your grad year',
                  ),
                  sh16,
                  Text(
                    'GPA',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your GPA',
                  ),
                  sh16,
                  Text(
                    'Sports',
                    style: h5,
                  ),
                  sh8,
                  // CustomTextField(
                  //   hintText: 'Drop down here',
                  //   sufIcon: Image.asset(
                  //     AppImages.arrowDown,
                  //     scale: 4,
                  //   ),
                  // ),

                  Container(
                    height: 54,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.greyLight,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedSport,
                        dropdownColor: AppColors.white,
                        isExpanded: true,
                        icon: Image.asset(AppImages.arrowDown,scale: 4,),
                        hint: Text(
                          'Drop down here',
                          style: h6.copyWith(color: AppColors.grey),
                        ),
                        items: ['Softball', 'Baseball', 'Soccer'].map((String sport) {
                          return DropdownMenuItem<String>(
                            value: sport,
                            child: Text(
                              sport,
                              style: h5,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSport = newValue; // Update the selected value
                          });
                        },
                      ),
                    ),
                  ),
                  sh16,
                  Text(
                    'Height',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your height',
                  ),
                  sh16,
                  Text(
                    'Primary position',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your primary position',
                  ),
                  sh16,
                  Text(
                    'Secondary position',
                    style: h5,
                  ),
                  sh8,
                  CustomTextField(
                    hintText: 'Enter your secondary position',
                  ),
                  sh16,
                  _buildQuestion(
                    'Are you ?',
                    ['Left handed', 'Right handed'],
                    handPreference,
                    (value) {
                      setState(() {
                        handPreference = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildQuestion(
                    'Are you ?',
                    ['Bat left', 'Bat right'],
                    batPreference,
                    (value) {
                      setState(() {
                        batPreference = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildQuestion(
                    'Are you ?',
                    ['Throw left', 'Throw right'],
                    throwPreference,
                    (value) {
                      setState(() {
                        throwPreference = value;
                      });
                    },
                  ),
                ],
              ),
              sh40,
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  Get.to(() => SignUpTwoView());
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

  Widget _buildQuestion(String question, List<String> options,
      String? groupValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: h5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: options.map((option) {
            return Expanded(
              child: RadioListTile<String>(
                activeColor: AppColors.mainColor,

                contentPadding: EdgeInsets.zero,
                title: Text(
                  option,
                  style: h5.copyWith(fontSize: 12),
                ),
                value: option,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
