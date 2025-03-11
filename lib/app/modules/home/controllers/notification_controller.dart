import 'package:get/get.dart';
import 'package:stephtomo_app/common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notifications = Rx<NotificationModel>(NotificationModel(
      success: false, message: "", data: Data(data: [], meta: null)));
  var notificationList =
      <Datum>[].obs; // List to hold the data of notifications.

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }

  /// Get Notification List
  getNotification() async {
    try {
      isLoading(true);

      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Content-Type': "application/json",
        "Authorization": "Bearer, $token"
      };

      // Fetch the response from the API
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: Api.notification,
          headers: headers,
        ),
      );

      if (responseBody != null) {
        // Parse the response into the NotificationModel
        notifications.value = NotificationModel.fromJson(responseBody);

        // Clear the old notifications
        notificationList.clear();

        // Update the notificationList with the new data from the model
        if (notifications.value.data != null) {
          notificationList.addAll(notifications.value.data!.data);

          ///check needed
        }

        print("Notification list loaded, count: ${notificationList.length}");
      } else {
        throw 'Failed to load notifications!';
      }
    } catch (e) {
      print("Issue: ${e.toString()}");
      // Optionally show a Snackbar or handle the error.
      // kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }
}
