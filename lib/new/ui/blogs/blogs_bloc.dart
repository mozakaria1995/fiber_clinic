import 'dart:async';

import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/blog_model.dart';
import 'package:auth_manager/new/repositories/blogs_repo.dart';

class BlogsBloc extends BaseBloc {
  BlogsBloc(BaseView view) : super(view);

  BlogsRepo blogsRepo = BlogsRepo();

  StreamController<BlogsResponseModel?> blogsController = StreamController();

  void getBlogs() {
    blogsController.add(null);
    blogsRepo.getBlogs().then((response) {
      blogsController.add(response);
    }, onError: (error) {
      handleError(error);
      if (!blogsController.isClosed) {
        blogsController.addError(error);
      }
    });
  }

  @override
  void onDispose() {
    blogsRepo.dispose();
    blogsController.close();
  }
}
