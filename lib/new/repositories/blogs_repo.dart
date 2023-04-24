
import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/blog_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';

class BlogsRepo extends BaseRepo {
  Future<BlogsResponseModel?> getBlogs() {
    return networkManager.get<BlogsResponseModel>(Endpoints.BLOGS) ;
  }
}