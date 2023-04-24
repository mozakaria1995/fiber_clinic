import 'dart:io';

import 'package:auth_manager/new/base/base_state.dart';
import 'package:auth_manager/new/cache/app_cache.dart';
import 'package:auth_manager/new/model/user_model.dart';
import 'package:auth_manager/new/ui/user_profile/user_profile_bloc.dart';
import 'package:auth_manager/new/utils/resoures/assets_manager.dart';
import 'package:auth_manager/new/utils/resoures/color_manager.dart';
import 'package:auth_manager/new/utils/resoures/font_manager.dart';
import 'package:auth_manager/new/utils/resoures/values_manager.dart';
import 'package:auth_manager/new/widgets/app_button_widget.dart';
import 'package:auth_manager/new/widgets/input_form_field.dart';
import 'package:auth_manager/new/widgets/title_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState
    extends BaseState<UserProfileScreen, UserProfileBloc> {
  GlobalKey<FormState> _textFormState = GlobalKey<FormState>();

  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController diseasesController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController insuranceCompanyController = TextEditingController();

  File? pickedImage;
  int? genderRadioSelection;

  bool isAbsorbingDiseaseText = true;
  bool isAbsorbingNationalIdText = true;
  bool isAbsorbingMedicineText = true;
  bool isAbsorbingInsuranceCompanyText = true;

  UserDataModel? userData = AppCache.instance.getUserModel();

  @override
  void initBloc() {
    bloc = UserProfileBloc(this);
  }

  @override
  void initState() {
    super.initState();
    setGender();
  }

  @override
  Widget buildWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.scaffoldBackGround,
        shadowColor: Colors.transparent,
        title: Text("الملف الشخصي",
            style: TextStyle(
                color: ColorManager.primary,
                fontFamily: FontManager.fontFamily,
                fontWeight: FontWeightManager.semiBold,
                fontSize: FontSizeManager.s16)),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _textFormState,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: AppMargin.m14),
            children: [
              GestureDetector(
                onTap: () async => pickImage(),
                child: userData!.data!.photo != null && pickedImage == null
                    ? CachedNetworkImage(
                        imageUrl: userData!.data!.photo!,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          FontAwesomeIcons.userCircle,
                          size: 120,
                        ),
                        imageBuilder: (context, imageProvider) => Center(
                          child: CircleAvatar(
                            backgroundImage: imageProvider,
                            minRadius: 80,
                            maxRadius: 100,
                          ),
                        ),
                      )
                    : pickedImage == null
                        ? Icon(
                            FontAwesomeIcons.userCircle,
                            size: 80,
                          )
                        : Center(
                            child: CircleAvatar(
                              minRadius: 80,
                              maxRadius: 100,
                              backgroundImage: FileImage(pickedImage!),
                            ),
                          ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              TitleWidget(
                title: "الوزن",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showWeightPicker(),
                child: AbsorbPointer(
                  absorbing: true,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    textInputAction: TextInputAction.next,
                    validationText: "",
                    hintText: "تعديل",
                    width: size.width * 0.3,
                    lines: 1,
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    obscure: false,
                    height: AppSize.s60,
                    suffix: weightController.text.isNotEmpty
                        ? Image.asset(ImageAssets.check)
                        : Image.asset(ImageAssets.error),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              TitleWidget(
                title: "الطول",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showHeightPicker(),
                child: AbsorbPointer(
                  absorbing: true,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    hintText: "تعديل",
                    textInputAction: TextInputAction.next,
                    validationText: "",
                    width: size.width * 0.3,
                    lines: 1,
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    obscure: false,
                    height: AppSize.s60,
                    suffix: heightController.text.isNotEmpty
                        ? Image.asset(ImageAssets.check)
                        : Image.asset(ImageAssets.error),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TitleWidget(
                title: "العمر",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showAgePicker(),
                child: AbsorbPointer(
                  absorbing: isAbsorbingDiseaseText,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    hintText: "تعديل",
                    textInputAction: TextInputAction.next,
                    validationText: "",
                    width: size.width * 0.3,
                    lines: 1,
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    obscure: false,
                    height: AppSize.s60,
                    suffix: ageController.text.isNotEmpty
                        ? Image.asset(ImageAssets.check)
                        : Image.asset(ImageAssets.error),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TitleWidget(
                title: "النوع",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: genderRadioSelection,
                        activeColor: ColorManager.primary,
                        onChanged: (value) {
                          setState(() {
                            setState(() {
                              genderRadioSelection = 1;
                            });
                          });
                        },
                      ),
                      Text(
                        "ذكر",
                        style: TextStyle(
                            fontSize: AppSize.s16,
                            color: Colors.black,
                            fontFamily: FontManager.fontFamily,
                            fontWeight: FontWeightManager.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: genderRadioSelection,
                        activeColor: Colors.pink,
                        onChanged: (value) {
                          setState(() {
                            setState(() {
                              genderRadioSelection = 2;
                            });
                          });
                        },
                      ),
                      Text(
                        "أنثي",
                        style: TextStyle(
                            fontSize: AppSize.s16,
                            color: Colors.black,
                            fontFamily: FontManager.fontFamily,
                            fontWeight: FontWeightManager.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s20),
              TitleWidget(
                title: "الآمراض",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showDiseases(),
                child: AbsorbPointer(
                  absorbing: isAbsorbingDiseaseText,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    textInputAction: TextInputAction.next,
                    hintText: isAbsorbingDiseaseText ? "تعديل" : "",
                    validationText: "",
                    width: size.width,
                    lines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: diseasesController,
                    obscure: false,
                    height: AppSize.s60,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TitleWidget(
                title: "ما هي الأدوية المستخدمة بصفة منتظمة ؟؟ 'إن وجد'",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showMedicines(),
                child: AbsorbPointer(
                  absorbing: isAbsorbingMedicineText,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    textInputAction: TextInputAction.next,
                    hintText: isAbsorbingMedicineText ? "تعديل" : "",
                    validationText: "",
                    width: size.width,
                    lines: 3,
                    keyboardType: TextInputType.multiline,
                    controller: medicineController,
                    obscure: false,
                    height: AppSize.s60,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TitleWidget(
                title: "الرقم القومي",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showNationalId(),
                child: AbsorbPointer(
                  absorbing: isAbsorbingNationalIdText,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    textInputAction: TextInputAction.next,
                    hintText: isAbsorbingNationalIdText ? "تعديل" : "",
                    validationText: "",
                    width: size.width,
                    lines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: nationalIdController,
                    obscure: false,
                    height: AppSize.s60,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TitleWidget(
                title: "ما هي شركة التأمين المتعاقد معها ؟؟ 'إن وجد'",
                fontSize: AppSize.s16,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () => showInsuranceCompany(),
                child: AbsorbPointer(
                  absorbing: isAbsorbingInsuranceCompanyText,
                  child: InputFieldWidget(
                    isUnderLinedTextField: true,
                    textInputAction: TextInputAction.next,
                    hintText: isAbsorbingInsuranceCompanyText ? "تعديل" : "",
                    validationText: "",
                    width: size.width,
                    lines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: insuranceCompanyController,
                    obscure: false,
                    height: AppSize.s60,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s60),
              Center(
                child: AppButton(
                  buttonColor: ColorManager.primary,
                  onPressed: () async {
                    if (validate()) {
                      if (await bloc.updateProfile(
                          UserDataModel(
                            data: Data(
                                height: heightController.text,
                                weight: weightController.text,
                                age: ageController.text,
                                diseases: diseasesController.text,
                                gender: (genderRadioSelection == null)
                                    ? ""
                                    : (genderRadioSelection == 1
                                        ? "male"
                                        : "female"),
                                insuranceCompany:
                                    insuranceCompanyController.text,
                                medicines: medicineController.text,
                                nationalId: nationalIdController.text),
                          ),
                          selectedImage: pickedImage)) {
                        showSuccessMsg("تم تعديل البيانات بنجاح !");
                        Navigator.pop(context);
                      }
                    } else {
                      showErrorMsg("الرجاء تعديل البيانات أولاً !");
                    }
                  },
                  title: "تعديل",
                  width: size.width * 0.7,
                ),
              ),
              const SizedBox(height: AppSize.s20),
            ],
          ),
        ),
      ),
    );
  }

  void showAgePicker() {
    showMaterialNumberPicker(
      context: context,
      title: 'اختر عمرك',
      maxNumber: 120,
      minNumber: 5,
      cancelText: "إلغاء",
      confirmText: "تأكيد",
      onChanged: (value) =>
          setState(() => ageController.text = value.toString()),
      selectedNumber: int.parse(
        AppCache.instance.getUserModel()!.data!.age!,
        onError: (source) => 5,
      ),
    );
  }

  void showHeightPicker() {
    showMaterialNumberPicker(
      context: context,
      title: 'اختر طولك',
      maxNumber: 250,
      minNumber: 50,
      cancelText: "إلغاء",
      confirmText: "تأكيد",
      selectedNumber: int.parse(
        AppCache.instance.getUserModel()!.data!.height!,
        onError: (source) => 50,
      ),
      onChanged: (value) =>
          setState(() => heightController.text = value.toString()),
    );
  }

  void showWeightPicker() {
    showMaterialNumberPicker(
      context: context,
      title: 'اختر وزنك',
      maxNumber: 250,
      minNumber: 4,
      cancelText: "إلغاء",
      confirmText: "تأكيد",
      onChanged: (value) =>
          setState(() => weightController.text = value.toString()),
      selectedNumber: int.parse(
        AppCache.instance.getUserModel()!.data!.weight!,
        onError: (source) => 4,
      ),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        // imageQuality: 85,
        maxHeight: 200,
        maxWidth: 200);

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings:[
        AndroidUiSettings(
            toolbarTitle: 'Crop The selected image',
            toolbarColor: ColorManager.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop The selected image',
        ),




      ]
    );
    setState(() {
      // if (croppedFile != null) {
      //   pickedImage = new File(croppedFile.path);
      // } else {
      //   print('No image selected.');
      // }
    });
  }

  bool validate() {
    return heightController.text.isNotEmpty ||
        weightController.text.isNotEmpty ||
        ageController.text.isNotEmpty ||
        diseasesController.text.isNotEmpty ||
        nationalIdController.text.isNotEmpty ||
        medicineController.text.isNotEmpty ||
        insuranceCompanyController.text.isNotEmpty ||
        genderRadioSelection != null ||
        pickedImage != null;
  }

  void showDiseases() {
    setState(() {
      isAbsorbingDiseaseText = false;
      diseasesController.text = userData?.data?.diseases ?? "";
    });
  }

  void setGender() {
    setState(() {
      if (userData?.data?.gender?.toLowerCase() == "male") {
        genderRadioSelection = 1;
      } else if (userData?.data?.gender?.toLowerCase() == "female") {
        genderRadioSelection = 2;
      }
    });
  }

  void showNationalId() {
    setState(() {
      isAbsorbingNationalIdText = false;
      nationalIdController.text = userData?.data?.nationalId ?? "";
    });
  }

  void showMedicines() {
    setState(() {
      isAbsorbingMedicineText = false;
      medicineController.text = userData?.data?.medicines ?? "";
    });
  }

  void showInsuranceCompany() {
    setState(() {
      isAbsorbingInsuranceCompanyText = false;
      insuranceCompanyController.text = userData?.data?.insuranceCompany ?? "";
    });
  }
}
