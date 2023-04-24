import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/new/model/blog_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blogModel;

  BlogCard({required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: blogModel.photo ?? "",
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                blogModel.title ?? "",
                style: TextStyle(color: kTitleTextColor, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              blogModel.description ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
