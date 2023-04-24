import 'package:auth_manager/models/blog_model.dart';
import 'package:auth_manager/services/blogs_service.dart';
import 'package:get/state_manager.dart';

class BlogsController extends GetxController {
  Rxn<List<BlogModel>> blogs = Rxn<List<BlogModel>>();

  @override
  void onInit() async {
    blogs.value = await BlogsService().getBlogs();
    super.onInit();
  }
}
