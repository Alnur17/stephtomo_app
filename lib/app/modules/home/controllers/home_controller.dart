import 'package:get/get.dart';

class HomeController extends GetxController {
  var savedColleges = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  var filteredData = <Map<String, dynamic>>[].obs;

  // Initialize with all data
  void initializeData(List<Map<String, dynamic>> data) {
    filteredData.assignAll(data);
  }

  void toggleSaveCollege(Map<String, dynamic> college) {
    if (savedColleges.contains(college)) {
      savedColleges.remove(college);
    } else {
      savedColleges.add(college);
    }
  }

  bool isSaved(Map<String, dynamic> college) {
    return savedColleges.contains(college);
  }

  void searchColleges(String query, List<Map<String, dynamic>> data) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredData.assignAll(data);
    } else {
      filteredData.assignAll(
        data.where((college) {
          return college['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
              college['university']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList(),
      );
    }
  }
}
