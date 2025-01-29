import 'package:get/get.dart';

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/college_model.dart';

class HomeController extends GetxController {
  var savedColleges = <Datum>[].obs;
  var searchQuery = ''.obs;
  var filteredData = <Datum>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollegeData();
  }

  /// **Fetch College Data from API**
  Future<void> fetchCollegeData() async {
    try {
      isLoading(true);

      var response = await BaseClient.getRequest(api: Api.collegeData);
      var responseData = await BaseClient.handleResponse(response);

      if (responseData != null) {
        CollegeModel collegeModel = CollegeModel.fromJson(responseData);
        filteredData.assignAll(collegeModel.data?.data ?? []);
      }
    } catch (e) {
      print("Error fetching college data: $e");
    } finally {
      isLoading(false); // Hide loading state
    }
  }

  /// **Save or Unsaved a College**
  void toggleSaveCollege(Datum college) {
    if (savedColleges.contains(college)) {
      savedColleges.remove(college);
    } else {
      savedColleges.add(college);
    }
  }

  /// **Check if a College is Saved**
  bool isSaved(Datum college) {
    return savedColleges.contains(college);
  }

  /// **Search for Colleges Based on Query**
  void searchColleges(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      fetchCollegeData(); // Reload data if query is empty
    } else {
      filteredData.assignAll(
        filteredData.where((college) {
          return (college.collegeName?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (college.coachName?.toLowerCase().contains(query.toLowerCase()) ?? false);
        }).toList(),
      );
    }
  }
}
