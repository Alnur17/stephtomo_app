import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/college_profile_card.dart';
import '../controllers/bookmarks_controller.dart';

class BookmarksView extends StatefulWidget {
  const BookmarksView({super.key});

  @override
  State<BookmarksView> createState() => _BookmarksViewState();
}

class _BookmarksViewState extends State<BookmarksView> {
  final BookmarksController bookmarkController = Get.put(BookmarksController());

  @override
  void initState() {
    super.initState();
    bookmarkController.getBookmarkedColleges();
  }

  Future<void> _refreshData() async {
    // This method is triggered when the user pulls to refresh
    await bookmarkController.getBookmarkedColleges();  // Call the method to fetch new data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        title: Text('Saved Colleges', style: titleStyle),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (bookmarkController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: AppColors.mainColor));
        }

        final savedColleges = bookmarkController.savedColleges;
        print("Rendering bookmarks: ${savedColleges.length} items");

        if (savedColleges.isEmpty) {
          return const Center(
            child: Text(
              'No saved colleges.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _refreshData,  // Trigger the data refresh
          child: ListView.builder(
            itemCount: savedColleges.length,
            itemBuilder: (context, index) {
              final college = savedColleges[index].college;  // Accessing the 'college' field from Datum
              print("Displaying college: ${college?.collegeName}");

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == savedColleges.length - 1 ? 100 : 8,
                  right: 16,
                  left: 16,
                ),
                child: CollegeProfileCard(
                  image: college?.image ?? '',  // College image
                  university: college?.collegeName ?? 'Unknown',  // College name
                  name: college?.coachName ?? 'Unknown',  // Coach's name
                  role: college?.coachTitle ?? '',  // Coach's title/role
                  email: college?.coachEmail ?? '',  // Coach's email
                  isSaved: bookmarkController.isSaved(savedColleges[index]),
                  onFacebookTap: () {},
                  onTwitterTap: () {},
                  onInstagramTap: () {},
                  onBookmarkTap: () {
                    // Implement the toggle logic for bookmarking
                    // bookmarkController.toggleSaveCollege(savedColleges[index]);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
