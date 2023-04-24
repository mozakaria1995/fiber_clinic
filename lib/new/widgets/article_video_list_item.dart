import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticleVideoItem extends StatelessWidget {
  final dynamic model;
  final Function() onTap;

  ArticleVideoItem({this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16),
      child: Container(
        height: size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            title: TitleWidget(
              title:  model.title!,
              color: ColorManager.black,
              fontSize: Theme.of(context).textTheme.headline1!.fontSize!,
            ),
            onTap: onTap,
            trailing: Container(
              height: size.width * 0.3,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                color: ColorManager.grey1,
                boxShadow: [BoxShadow(color: ColorManager.grey1, blurRadius: 0.5)],
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) => Center(
                  child: const CircularProgressIndicator(),
                ),
                imageUrl: model.photo,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Center(
                  child: const Icon(Icons.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*Column(
      children: [
        Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s8),
              topRight: Radius.circular(AppSize.s8),
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              model.title!,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontManager.fontFamily,
                  fontWeight: FontWeightManager.medium,
                  fontSize: 18),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: UnconstrainedBox(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: size.width * 0.6,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: ColorManager.grey1,
                  boxShadow: [
                    BoxShadow(color: ColorManager.grey1, blurRadius: 0.5)
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppSize.s8),
                    bottomRight: Radius.circular(AppSize.s8),
                  ),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: const CircularProgressIndicator(),
                  ),
                  imageUrl: model.photo,
                    fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Center(
                    child: const Icon(Icons.error),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
