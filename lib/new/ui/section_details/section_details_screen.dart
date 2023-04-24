import 'package:auth_manager/new/model/Video_list_model.dart';
import 'package:auth_manager/new/model/article_list_model.dart';
import 'package:auth_manager/new/model/spicialties_response_model.dart';
import 'package:auth_manager/new/ui/intro_video/video_screen.dart';
import 'package:auth_manager/new/ui/section_details/section_details_bloc.dart';
import 'package:auth_manager/new/ui/section_view/section_view_screen.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/article_video_list_item.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:auth_manager/widgets/tab_bar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SectionDetailsScreen extends StatefulWidget {
  final Specialty specialty;

  const SectionDetailsScreen({required this.specialty});

  @override
  State<SectionDetailsScreen> createState() => _SectionDetailsScreenState();
}

class _SectionDetailsScreenState
    extends BaseState<SectionDetailsScreen, SectionDetailsBloc> {
  late ArticleListModel articleList;
  late VideoListModel videoList;
  bool isBlogSectionSelected = false;

  @override
  Widget buildWidget(BuildContext context) {
    print(isBlogSectionSelected);
    // TODO: implement buildWidget
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.scaffoldBackGround,
        shadowColor: Colors.transparent,
        title: Text(widget.specialty.title!,
            style: TextStyle(
                color: ColorManager.primary,
                fontFamily: FontManager.fontFamily,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSizeManager.s16)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: TabBarWidget(

                onFirstTabTapped: () {
                  print("ziko");
                  setState(() {
                    isBlogSectionSelected =false;
                  });
                  bloc.getVideoList(widget.specialty.id!);

                },
                onSecondTabTapped: () {


                  setState(() {
                    isBlogSectionSelected = true;
                  });
                  bloc.getBlogList(widget.specialty.id!);

                },
                firstTabTitle: "مقالات",
                secondTabTitle: "فيديوهات",
                firstTabPressed: isBlogSectionSelected),
          ),
          Visibility(
            visible: isBlogSectionSelected,
            child: Expanded(
              child: StreamBuilder<ArticleListModel?>(
                  stream: bloc.blogListController.stream,
                  builder:
                      (context, AsyncSnapshot<ArticleListModel?> snapshot) {
                    if (snapshot.hasData) {
                      articleList = snapshot.data!;

                      return ListView.builder(
                        itemCount: articleList.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ArticleVideoItem(
                            model: articleList.data![index],
                            onTap: () => navigateTo(SectionViewScreen(
                              specialty: widget.specialty,
                              articleModel: articleList.data![index],
                            )),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: !isBlogSectionSelected,
            child: Expanded(
              child: StreamBuilder<VideoListModel?>(
                  stream: bloc.videoListController.stream,
                  builder:
                      (context, AsyncSnapshot<VideoListModel?> snapshot) {
                    if (snapshot.hasData) {
                      videoList = snapshot.data!;
                      return ListView.builder(
                        itemCount: videoList.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: AppPadding.p20, right: AppPadding.p20),
                            child: ArticleVideoItem(
                              onTap: () => navigateTo(
                                IntroVideo(
                                  videoUrl: videoList.data![index].path!,
                                  buttonText: 'رجوع',
                                  appBarTitle: videoList.data![index].title!,
                                  onButtonTapped: () =>
                                      Navigator.pop(context),
                                ),
                              ),
                              model: videoList.data![index],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initBloc() {
    // TODO: implement initBloc
    bloc = SectionDetailsBloc(this);
    bloc.getVideoList(widget.specialty.id!);
  }
}
