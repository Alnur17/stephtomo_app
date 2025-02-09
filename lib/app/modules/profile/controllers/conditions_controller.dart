import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stephtomo_app/app/data/api.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../model/conditions_model.dart';

class ConditionsController extends GetxController {
  var isLoading = true.obs;
  var conditionsData = <Datum>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchConditions();
    super.onInit();
  }

  /// API Call to Fetch Conditions Data
  void fetchConditions() async {
    try {
      isLoading(true);
      String token = LocalStorage.getData(key: AppConstant.token);

      var headers = {
        'Content-Type': "application/json",
        "Authorization": "Bearer, $token"
      };

      var response = await http.get(Uri.parse(Api.conditionsPage), headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        ConditionsModel conditions = ConditionsModel.fromJson(jsonData);
        conditionsData.assignAll(conditions.data);
      } else {
        errorMessage.value = "Failed to load data: ${response.body}";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  /// Method to get Privacy Policy text
  String getPrivacyPolicy() {
    return conditionsData.isNotEmpty ? conditionsData.first.privacyPolicy ?? "No Data Available" : "Loading...";
  }

  /// Method to get Terms & Conditions text
  String getTermsConditions() {
    return conditionsData.isNotEmpty ? conditionsData.first.termsConditions ?? "No Data Available" : "Loading...";
  }

  /// Method to get About Us text
  String getAboutUs() {
    return conditionsData.isNotEmpty ? conditionsData.first.aboutUs ?? "No Data Available" : "Loading...";
  }
}

