import 'dart:async';
import 'package:auth_manager/new/base/base_bloc.dart';
import 'package:auth_manager/new/base/base_view.dart';
import 'package:auth_manager/new/model/Video_list_model.dart';
import 'package:auth_manager/new/model/article_list_model.dart';
import 'package:auth_manager/new/model/contactus_model.dart';
import 'package:auth_manager/new/model/doctor_info_model.dart';
import 'package:auth_manager/new/repositories/doctor_details_repo.dart';
import 'package:auth_manager/new/repositories/section_details_repo.dart';
import 'package:rxdart/rxdart.dart';

class SectionViewBloc extends BaseBloc {
  SectionViewBloc(BaseView view) : super(view);

  SectionDetailsRepo sectionDetailsRepo = SectionDetailsRepo();
  StreamController<ArticleListModel?> blogListController =
  BehaviorSubject();
  StreamController<VideoListModel?> videoListController = BehaviorSubject();

  void getBlogList(int sectionId) {
    blogListController.sink.add(null);
    sectionDetailsRepo.getArticleList(sectionId: sectionId).then((response) {
      print(response);
      blogListController.sink.add(response);
    }, onError: (error) {
      handleError(error);
      if (!blogListController.isClosed) {
        blogListController.addError(error);
      }
    });
  }
  void getVideoList(int sectionId) {
    videoListController.sink.add(null);
    sectionDetailsRepo.getVideoList(sectionId: sectionId).then((response) {
      print(response);
      videoListController.sink.add(response);
    }, onError: (error) {
      handleError(error);
      if (!videoListController.isClosed) {
        videoListController.addError(error);
      }
    });
  }

  @override
  void onDispose() {
    blogListController.close();
    videoListController.close();
    sectionDetailsRepo.dispose();
  }
}
