import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_list_tile.dart';
import '../controllers/profile_controller.dart';
import '../../sign_in/views/sign_in_view.dart';
import '../views/about_us_view.dart';
import '../views/all_email_history_view.dart';
import '../views/edit_profile_view.dart';
import '../views/privacy_policy_view.dart';
import '../views/settings_view.dart';
import '../views/subscription_plan_view.dart';
import '../views/terms_of_conditions_view.dart';

class ProfileView extends GetView<ProfileController> {
  final bool showBackButton;

  const ProfileView({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text('Profile', style: titleStyle),
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
      body: Obx(
        () => profileController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: AppColors.mainColor))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    sh30,
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            profileController.profileData.value?.profileImage !=
                                    null
                                ? NetworkImage(profileController
                                    .profileData.value!.profileImage!)
                                : AssetImage(AppImages.profileAvatarPlaceholder)
                                    as ImageProvider,
                      ),
                      title: Text(
                        profileController.profileName.value,
                        style: h3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        profileController.email.value,
                        style: h4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: GestureDetector(
                        onTap: () => Get.to(() => EditProfileView()),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.blueDark,
                          ),
                          child: Image.asset(AppImages.edit, scale: 4),
                        ),
                      ),
                    ),
                    sh30,
                    Divider(),
                    _buildProfileOption(
                        AppImages.history, "History", AllEmailHistoryView()),
                    _buildProfileOption(AppImages.subscription, "Subscription",
                        SubscriptionPlanView()),
                    _buildProfileOption(
                        AppImages.settings, "Settings", SettingsView()),
                    _buildProfileOption(AppImages.termsAndCondition,
                        "Terms of Services", TermsOfConditionsView()),
                    _buildProfileOption(AppImages.privacy, "Privacy Policy",
                        PrivacyPolicyView()),
                    _buildProfileOption(
                        AppImages.info, "About us", AboutUsView()),
                    //Divider(),
                    CustomListTile(
                      onTap: _showLogoutPopup,
                      leading: AppImages.logout,
                      title: 'Log Out',
                    ),
                    sh24,
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileOption(String icon, String title, Widget view) {
    return Column(
      children: [
        CustomListTile(
          onTap: () => Get.to(() => view),
          leading: icon,
          title: title,
        ),
        Divider(),
      ],
    );
  }

  void _showLogoutPopup() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Do you want to logout?',
            style: h3, textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  log('========== User token ========== ${LocalStorage.getData(key: AppConstant.token)}');
                  LocalStorage.removeData(key: AppConstant.token);
                  Get.offAll(() => SignInView(),
                      transition: Transition.leftToRight);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.mainColor, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: Size(100, 40),
                ),
                child: Text(
                  'Yes',
                  style: h3.copyWith(fontSize: 14, color: AppColors.mainColor),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: Size(100, 40),
                ),
                child: Text(
                  'No',
                  style: h3.copyWith(fontSize: 14, color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
