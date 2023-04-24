import 'package:auth_manager/config/constant.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/model/blog_model.dart';
import 'package:auth_manager/new/ui/blogs/blogs_bloc.dart';
import 'package:auth_manager/new/widgets/blog_card_widget.dart';
import 'package:flutter/material.dart';

class BlogsScreen extends StatefulWidget {
  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends BaseState<BlogsScreen, BlogsBloc> {
  @override
  void initState() {
    super.initState();
    bloc.getBlogs();
  }

  @override
  Widget buildWidget(BuildContext context) {
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<BlogsResponseModel?>(
              stream: bloc.blogsController.stream,
              builder: (context, AsyncSnapshot<BlogsResponseModel?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.data!.length <= 0) {
                    return Text("No Blogs Availaible");
                  } else {
                    return Flexible(
                        child: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      itemBuilder: (context, index) {
                        return BlogCard(
                          blogModel: snapshot.data!.data![index],
                        );
                      },
                    ));
                  }
                } else if (snapshot.hasError) {
                  return Center();
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initBloc() {
    bloc = BlogsBloc(this);
  }
}
