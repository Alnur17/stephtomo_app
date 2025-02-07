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
    await bookmarkController.getBookmarkedColleges();
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
          onRefresh: _refreshData,
          child: ListView.builder(
            itemCount: savedColleges.length,
            itemBuilder: (context, index) {
              final college = savedColleges[index].college;
              print("Displaying college: ${college?.collegeName}");

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == savedColleges.length - 1 ? 100 : 8,
                  right: 16,
                  left: 16,
                ),
                child: CollegeProfileCard(
                  image: college?.image ?? '',
                  university: college?.collegeName ?? 'Unknown',
                  name: college?.coachName ?? 'Unknown',
                  role: college?.coachTitle ?? '',
                  email: college?.coachEmail ?? '',
                  isSaved: bookmarkController.isSaved(savedColleges[index]),
                  onFacebookTap: () {},
                  onTwitterTap: () {},
                  onInstagramTap: () {},
                  onBookmarkTap: () {
                    bookmarkController.toggleSaveCollege(savedColleges[index]);
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
