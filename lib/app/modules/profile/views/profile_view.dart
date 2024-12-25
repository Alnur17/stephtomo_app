import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/profile/views/about_us_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/all_email_history_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/edit_profile_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/privacy_policy_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/settings_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/subscription_plan_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/terms_of_conditions_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_list_tile.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool showBackButton;

  const ProfileView({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          'Profile',
          style: titleStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: showBackButton,
        leading: showBackButton
            ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImages.back,
                  scale: 4,
                ),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            sh30,
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  AppImages.profile,
                ),
              ),
              title: Text(
                'Sultan Md. Alnur',
                style: h3,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'abc0126@gmail.com',
                style: h4,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: GestureDetector(
                  onTap: () {
                    Get.to(() => EditProfileView());
                  },
                  child: Image.asset(
                    AppImages.edit,
                    scale: 4,
                  )),
            ),
            sh30,
            Divider(),
            CustomListTile(
              onTap: () {
                Get.to(() => AllEmailHistoryView());
              },
              leading: AppImages.history,
              title: 'History',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                Get.to(() => SubscriptionPlanView());
              },
              leading: AppImages.subscription,
              title: 'Subscription',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                Get.to(() => SettingsView());
              },
              leading: AppImages.settings,
              title: 'Settings',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                Get.to(() => TermsOfConditionsView());
              },
              leading: AppImages.termsAndCondition,
              title: 'Terms of Services',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                Get.to(
                  () => PrivacyPolicyView(),
                );
              },
              leading: AppImages.privacy,
              title: 'Privacy Policy',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                Get.to(() => AboutUsView());
              },
              leading: AppImages.info,
              title: 'About us',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                _showLogoutPopup();
              },
              leading: AppImages.logout,
              title: 'Log Out',
            ),
            sh24,
          ],
        ),
      ),
    );
  }

  void _showLogoutPopup() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Do you want to logout your profile?',
          style: h3,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  Get.offAll(() => SignInView(),
                      transition: Transition.leftToRight);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.mainColor, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(100, 40),
                ),
                child: Text(
                  'Yes',
                  style: h3.copyWith(
                    fontSize: 14,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(100, 40),
                ),
                child: Text(
                  'No',
                  style: h3.copyWith(
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
