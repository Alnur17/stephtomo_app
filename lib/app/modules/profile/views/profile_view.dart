import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/profile/views/about_us_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/edit_profile_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/privacy_policy_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/settings_view.dart';
import 'package:stephtomo_app/app/modules/profile/views/terms_of_conditions_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_list_tile.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
        automaticallyImplyLeading: false,
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
                // Get.to(() => EditProfileView());
              },
              leading: AppImages.history,
              title: 'History',
            ),
            Divider(),
            CustomListTile(
              onTap: () {
                //Get.to(() => TrackOrderView());
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
                 Get.to(() => PrivacyPolicyView(),);
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
                Get.offAll(() => SignInView(),
                    transition: Transition.leftToRight);
              },
              leading: AppImages.logout,
              title: 'Log Out',
            ),
            sh24
          ],
        ),
      ),
    );
  }
}
