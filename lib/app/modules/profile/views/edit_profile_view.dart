import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../../common/widgets/custom_textfelid.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController profileController = Get.find<ProfileController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController clubTeamController = TextEditingController();
  final TextEditingController clubCoachNameController = TextEditingController();
  final TextEditingController clubCoachEmailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    nameController.text = profileController.profileData.value?.name ?? '';
    heightController.text = profileController.profileData.value?.height ?? '';
    positionController.text = profileController.profileData.value?.primaryPosition ?? '';
    clubTeamController.text = profileController.profileData.value?.clubTeam ?? '';
    clubCoachNameController.text = profileController.profileData.value?.clubCoachName ?? '';
    clubCoachEmailController.text = profileController.profileData.value?.clubCoachEmail ?? '';
    addressController.text = profileController.profileData.value?.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: const Text('Edit Profile'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sh20,

              // Profile Picture Selection
              Obx(() => Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: profileController.selectedImage.value != null
                        ? FileImage(profileController.selectedImage.value!)
                        : (profileController.profileData.value?.profileImage != null &&
                        profileController.profileData.value!.profileImage!.isNotEmpty)
                        ? NetworkImage(profileController.profileData.value!.profileImage!)
                        : AssetImage(AppImages.profileAvatarPlaceholder) as ImageProvider,
                  ),
                  // CachedNetworkImage(
                  //   imageUrl: profileController.profileData.value?.profileImage ?? '',
                  //   placeholder: (context, url) => CircleAvatar(
                  //     radius: 60,
                  //     backgroundColor: AppColors.grey,
                  //   ),
                  //   errorWidget: (context, url, error) => CircleAvatar(
                  //     radius: 60,
                  //     backgroundImage: AssetImage(AppImages.profileAvatarPlaceholder),
                  //   ),
                  //   imageBuilder: (context, imageProvider) => CircleAvatar(
                  //     radius: 60,
                  //     backgroundImage: imageProvider,
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: profileController.pickImage,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: AppColors.blueLight,
                        ),
                        child: Image.asset(AppImages.editProfile, scale: 4),
                      ),
                    ),
                  ),
                ],
              )),

              sh16,

              // All Text Fields
              _buildTextField("Name", nameController),
              _buildTextField("Height", heightController),
              _buildTextField("Primary Position", positionController),
              _buildTextField("Club Team", clubTeamController),
              _buildTextField("Club Coach Name", clubCoachNameController),
              _buildTextField("Club Coach Email", clubCoachEmailController),
              _buildTextField("Address", addressController),

              sh20,

              // Update Button
              CustomButton(
                text: 'Update',
                onPressed: () {
                  final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (clubCoachEmailController.text.isNotEmpty && !emailRegExp.hasMatch(clubCoachEmailController.text)) {
                    kSnackBar(
                      message: "Please enter a valid Club Coach Email",
                      bgColor: AppColors.orange,
                    );
                    return;
                  }
                  profileController.updateProfile(
                    name: nameController.text,
                    height: heightController.text,
                    primaryPosition: positionController.text,
                    clubTeam: clubTeamController.text,
                    clubCoachName: clubCoachNameController.text,
                    clubCoachEmail: clubCoachEmailController.text,
                    address: addressController.text,
                  );
                },
              ),

              sh30,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: h5),
        sh8,
        CustomTextField(hintText: "Enter $label", controller: controller),
        sh16,
      ],
    );
  }
}
