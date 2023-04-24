import 'package:auth_manager/new/base/base_repo.dart';
import 'package:auth_manager/new/model/Video_list_model.dart';
import 'package:auth_manager/new/model/article_list_model.dart';
import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/network/Endpoints.dart';

class SectionDetailsRepo extends BaseRepo {
  //TODO
  Future<ArticleListModel?> getArticleList({required int sectionId}) {
    return networkManager.get<ArticleListModel>(Endpoints.ARTICLE_LIST,
        params: {"blog_type_id": sectionId});
  }
  Future<VideoListModel?> getVideoList({required int sectionId}) {
    return networkManager.get<VideoListModel>(Endpoints.VIDEO_LIST,
        params: {"blog_type_id": sectionId});
  }
}
