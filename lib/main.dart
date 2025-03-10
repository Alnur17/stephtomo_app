import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stephtomo_app/app/data/notification_services.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import 'package:stephtomo_app/common/helper/local_store.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

NotificationServices notificationServices = NotificationServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  notificationServices.requestNotificationPermission();
  notificationServices.getDeviceToken().then(
    (value) {
      debugPrint('=============== > Device Token: $value < ==================');
      LocalStorage.saveData(key: AppConstant.fcmToken, data: value);

      String fcmToken = LocalStorage.getData(key: AppConstant.fcmToken);

      debugPrint('=========>fcm Token from local storage: $fcmToken <========');
    },
  );

  runApp(
    GetMaterialApp(
      title: "ScoutStream",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
