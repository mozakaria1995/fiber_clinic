import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/controllers/blogs_controller.dart';
import 'package:auth_manager/models/blog_model.dart';
import 'package:auth_manager/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogsView extends StatelessWidget {
  final BlogsController blogsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(14), // This will be the login form
              child: Text(
                'Explore Blogs',
                style: TextStyle(
                    color: kTitleTextColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            buildBlogsList()
          ],
        ),
      ),
    );
  }

  buildBlogsList() {
    return Obx(() {
      List<BlogModel>? _blogs = blogsController.blogs.value;
      if (_blogs == null) {
        return Text("No Blogs Availaible");
      }
      return Flexible(
          child: ListView.builder(
        itemCount: _blogs.length,
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          return BlogCard(_blogs[index].title, _blogs[index].photo,
              _blogs[index].description);
        },
      ));
    });
  }
}
