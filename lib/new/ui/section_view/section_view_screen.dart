
import 'package:auth_manager/new/model/article_list_model.dart';
import 'package:auth_manager/new/model/spicialties_response_model.dart';
import 'package:auth_manager/new/ui/section_view/section_view_bloc.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:auth_manager/new/base/base_state.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../widgets/title_widget.dart';

class SectionViewScreen extends StatefulWidget {
  final Specialty specialty;
  final ArticleModel articleModel;

  const SectionViewScreen(
      {required this.specialty, required this.articleModel});

  @override
  State<SectionViewScreen> createState() => _SectionViewScreenState();
}

class _SectionViewScreenState
    extends BaseState<SectionViewScreen, SectionViewBloc> {


//   final htmlData = r"""
//
//       <h1>تعليق على "حكاية الأشياء" من ناشونال جيوغرافك</h1>
//       <p>انفعلت مع هذا الفيديو على مستويين، أولهما تركيز المذيعة على الدور الذي يلعبه الإنسان في نظام الاقتصاد الاستهلاكي والذي عادة لا يُذكر في التفسيرات الاقتصادية أو علم الاقتصاد بشكل عام. فتخبرنا المذيعة بأن علماء الاقتصاد قد رسموا صورة منظمة وبسيطة ليفسروا هذا النظام الاقتصادي الاستهلاكي بشكل مبسط وكأنه نظام متكافئ بدون سلبيات أو مشاكل. ولكن بالطبع هذا النظام له تأثير لا يستهان به على حياة الانسان. وثانيهما، المذيعة تحاول أن تغير المفهوم الشائع لهذا النظام، فتركيزها الأول ليس على رحلة "الأشياء" والإنسان الذي لولاه لما كان النظام موجود قط. الإنسان، حسب هذه المذيعة، يلعب الدور الأساسي في هذا النظام، فهو موجود في كل مرحلة من النظام، من الاستخراج إلى الرمي.
// في مرحلة الاستخراج... المذيعة تخبرنا بأننا في الوقت الراهن أصبحنا نستهلك مواردنا الطبيعية إلى الدرجة أن الكوكب لم يعد يقدر على الاستيعاب. وعندما يستنفد بلدان "العالم الأول" كل ما عندها من موارد طبيعية، لا تحاول أن تتوقف عن الاستخراج مستهدفةً الاستهلاك الاقتصادي بل تأخذ تستخرج الموارد الطبيعية المطلوبة من بلدان "العالم الثالث" كأنها ممتلكاتها هي، بغض النظر عن وضع الناس في هذه البلدان "غير المتقدمة" وحقهم لهذه الموارد الطبيعية. وأكثر ما لفت نظري في هذا الجزء، هو أن علماء الاقتصاد يتكلمون عن نظام الاقتصاد الاستهلاكي كأنه وضع طبيعي فيتجاهلون طرقات المعيشة التي كانت موجودة قبله وقد لا تزال أكثر تكافؤاً بيئياً. وبالأحرى، الناس على كوكب الأرض في كل البلدان كانوا يعيشون بطريقة لا تضر بالبيئة لمدة قرون، جيلا وراء جيل. لماذا؟ لأنها لا تشتري ولا تستهلك على الدرجة المطلوبة من قبل النظام الاستهلاكي.
// هذا ما اندهشني أكثر في هذا البرنامج: أدركت أننا نعيش في نظام لا يحترم الإنسان كرامته وشرفه وحتى إنسانيته، بل يسعي في إهانتها - من خلال الإعلانات الكثيفة الموجودة في كل مكان وخصوصاً على التلفيزيون—حتى تشتغل أكثر لكي تكسب أكثر لكي تضيع هذا النقود بشراء أشياء أكثر، كل هذا لكي يدعم نظام لا يحترمه ولايرحمه. وبالأحرى، كأننا نشتري "الأي بود" أو أي سلع على حساب انسانيتنا. فالمذيعة تجعلنا نتساءل: هل السلع تقابل انسانيتنا؟ وركزت المذيعة كثيرا على هذه النقطة: من المفروض أن تكون أول مسؤلية لأي نظام اقتصادي أو سياسي أن يدعم ويساعد ويحمي. لكن للأسف، نظامنا الاقتصادي الحالي يبيع روحنا من أجل الاستهلاك الدائم والأرباح اللانهائية.
// </p>
//       """;

  @override
  Widget buildWidget(BuildContext context) {
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
                fontSize: FontSizeManager.s16,)),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: TitleWidget(title: widget.articleModel.title!,fontSize: FontSizeManager.s20, color: ColorManager.primary,),
            ),
            Html(
              data: widget.articleModel.description,


              tagsList: Html.tags,
              style: {
                "table": Style(
                  backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                ),
                "tr": Style(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                "th": Style(
                  padding: EdgeInsets.all(6),
                  backgroundColor: Colors.grey,
                ),
                "td": Style(
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.topCenter,
                ),
                'h5': Style(
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
                'h1': Style(
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initBloc() {
    // TODO: implement initBloc
    bloc = SectionViewBloc(this);
    bloc.getBlogList(widget.specialty.id!);
  }
}
