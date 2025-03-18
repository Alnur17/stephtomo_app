import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stephtomo_app/app/modules/profile/views/widgets/plan_tile.dart';
import 'package:stephtomo_app/common/app_images/app_images.dart';
import 'package:stephtomo_app/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../controllers/subscription_plan_controller.dart';

// class SubscriptionPlanView extends StatefulWidget {
//   const SubscriptionPlanView({super.key});
//
//   @override
//   State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
// }
//
// class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
//   String selectedPlan = "Annual";
//   double selectedPrice = 100.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         scrolledUnderElevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//         title: Text(
//           'Subscription Plan',
//           style: titleStyle,
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             sh30,
//             Image.asset(
//               AppImages.subscriptionBox,
//               scale: 4,
//             ),
//             sh16,
//             sw12,
//             Text(
//               'Choose your plan',
//               style: h3,
//             ),
//             sh16,
//             Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedPlan = "Monthly";
//                       selectedPrice = 30.0;
//                     });
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: selectedPlan == "Monthly"
//                           ? AppColors.silver
//                           : AppColors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: selectedPlan == "Monthly"
//                             ? AppColors.mainColor
//                             : AppColors.grey,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Monthly',
//                               style: titleStyle.copyWith(color: AppColors.mainColor),
//                             ),
//                             sh8,
//                             Text(
//                               '15 message send',
//                               style: subTitleStyle.copyWith(color: AppColors.mainColor),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           '30\$ / Monthly',
//                           style: h3.copyWith(color: AppColors.mainColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 sh16,
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedPlan = "Annual";
//                       selectedPrice = 100.0;
//                     });
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: selectedPlan == "Annual"
//                           ? AppColors.silver
//                           : AppColors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: selectedPlan == "Annual"
//                             ? AppColors.mainColor
//                             : AppColors.grey,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Annual',
//                               style: titleStyle.copyWith(color: AppColors.mainColor),
//                             ),
//                             sh8,
//                             Text(
//                               'Unlimited message send',
//                               style: subTitleStyle.copyWith(color: AppColors.mainColor),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           '100\$ / Yearly',
//                           style: h3.copyWith(color: AppColors.mainColor),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             CustomButton(
//               text:
//                   'Continue with ${selectedPrice.toStringAsFixed(0)}\$/$selectedPlan',
//               onPressed: () {
//                 Get.to(()=> PaymentDetailsView(), arguments: {
//                   'plan': selectedPlan,
//                   'price': selectedPrice,
//                 });
//               },
//             ),
//             sh50
//           ],
//         ),
//       ),
//     );
//   }
// }

class SubscriptionPlanView extends StatefulWidget {
  const SubscriptionPlanView({super.key});

  @override
  State<SubscriptionPlanView> createState() => _SubscriptionPlanViewState();
}

class _SubscriptionPlanViewState extends State<SubscriptionPlanView> {
  final SubscriptionPlanController controller =
      Get.put(SubscriptionPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(AppImages.back, scale: 4),
        ),
        title: Text('Subscription Plan', style: titleStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.subscriptionPackages.isEmpty) {
              return const Center(
                  child: Text("No subscription plans available"));
            }
            return Column(
              children: [
                sh30,
                Image.asset(AppImages.subscriptionBox, scale: 4),
                sh16,
                Text('Choose your plan', style: h3),
                sh16,
                Column(
                  children: controller.subscriptionPackages.map((plan) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => controller.setPlan(
                            plan.packageName ?? "Unknown",
                            plan.price ?? 0.0,
                          ),
                          child: PlanTile(
                            title: plan.packageName ?? "Unknown",
                            price: plan.price ?? 0.0,

                            controller: controller,
                          ),
                        ),
                        sh16,
                      ],
                    );
                  }).toList(),
                ),
                sh16,
                Spacer(),
                CustomButton(
                  text:
                      'Continue with \$${controller.selectedPrice}/ ${controller.selectedPlan}',
                  onPressed: controller.createPaymentSession,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
