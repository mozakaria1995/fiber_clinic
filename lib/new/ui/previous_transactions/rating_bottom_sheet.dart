import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBottomSheet extends StatefulWidget {
  final Function(String rate, String review) onSubmitCallback;

  RatingBottomSheet({required this.onSubmitCallback});

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double rate = 5;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "رأيك يهمنا",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 20),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "يساعدنا التقييم علي تطوير خدمتنا لسيادتكم بأفضل صورة ممكنة ، لذا نود أن نعلم مدي رضائكم عن أداء الخدمة ، متمنيين لكم دوام الصحة و العافية",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bottomNavBar,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: RatingBar.builder(
                initialRating: rate,
                itemCount: 5,
                updateOnDrag: true,
                itemPadding: EdgeInsets.all(8),
                minRating: 1,
                glow: true,
                glowColor: Colors.white10,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rate = rating;
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "يسعدنا تلقي مقترحاتك و أرائك",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 20),
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: InputFieldWidget(
                textInputAction: TextInputAction.done,
                hintText: "اكتب هنا",
                width: size.width,
                lines: 6,
                keyboardType: TextInputType.multiline,
                controller: reviewController,
                obscure: false,
                height: 150,
                validation: true,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: AppButton(
                width: size.width * 0.4,
                title: "إرسال التقييم",
                buttonColor: Colors.green,
                onPressed: () => widget.onSubmitCallback(
                    "${rate.toInt()}", reviewController.text),
              ),
            )
          ]),
    );
  }
}
