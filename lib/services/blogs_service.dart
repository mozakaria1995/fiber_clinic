import 'package:auth_manager/config/config.dart';
import 'package:auth_manager/models/blog_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class BlogsService extends GetConnect {
  final String domainUrl = Endpoints.BASE_URL;

  Future<List<BlogModel>?> getBlogs() async {
    String url = domainUrl + "blogs";
    final response = await get(url);

    if (response.statusCode == HttpStatus.ok) {
      var body = response.body;
      if (body['data'].isNotEmpty) {
        var data = body['data'];
        List<BlogModel>? blogs;
        blogs = List.from(data.map((m) => BlogModel.successfromJson(m)));
        return blogs;
      }
    }
    return null;
  }
}
