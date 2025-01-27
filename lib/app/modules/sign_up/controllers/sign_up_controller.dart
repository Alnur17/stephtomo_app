import 'package:get/get.dart';
import 'package:stephtomo_app/app/data/api.dart';

import '../../../../common/helper/local_store.dart';
import '../../../data/base_client.dart';

class SignUpController extends GetxController {
  var firstScreenData = {}.obs; // Reactive state for first-screen data

  // Save first-screen data
  void saveFirstScreenData(Map<String, dynamic> data) {
    firstScreenData.assignAll(data);
    LocalStorage.saveData(
        key: 'firstScreenData', data: data); // Save to storage
  }

  // Retrieve first-screen data
  Map<String, dynamic> getStoredFirstScreenData() {
    return LocalStorage.getData(key: 'firstScreenData') ?? {};
  }

  // API call for sign-up
  Future<void> signUp(Map<String, dynamic> secondScreenData) async {
    final url = Api.signUp; // Use your API endpoint
    final requestBody = {
      ...firstScreenData, // Combine first screen data
      ...secondScreenData, // Combine second screen data
    };

    try {
      // Call API using BaseClient
      final response = await BaseClient.postRequest(
        api: url,
        body: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      // Handle response
      final responseData = await BaseClient.handleResponse(response);

      print("==========================$responseData=====================>");
      if (responseData != null) {
        // Save token and user info using LocalStorage
        LocalStorage.saveData(key: 'token', data: responseData['token']);
        LocalStorage.saveData(key: 'user', data: responseData['user']);

        // Success notification and navigate to dashboard
        Get.snackbar('Success', 'Account created successfully!');
        Get.offAllNamed('/dashboard'); // Update route as per your setup
      }
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', e.toString());
    }
  }
}
