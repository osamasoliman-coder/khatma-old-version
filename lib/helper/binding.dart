import 'package:get/get.dart';
import 'package:khatma/core/viewmodel/auth_view_model.dart';
import 'package:khatma/core/viewmodel/control_view_model.dart';
import 'package:khatma/core/viewmodel/details_view_model.dart';
import 'package:khatma/core/viewmodel/home_view_model.dart';
import 'package:khatma/core/viewmodel/khatma_chat_view_model.dart';
import 'package:khatma/core/viewmodel/khatma_view_model.dart';
import 'package:khatma/core/viewmodel/message_view_model.dart';
import 'package:khatma/core/viewmodel/myprofile_view_model.dart';
import 'package:khatma/core/viewmodel/quran_view_model.dart';
import 'package:khatma/core/viewmodel/search_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => KhatmaViewModel());
    Get.lazyPut(() => SearchViewModel());
    Get.lazyPut(() => DetailsViewModewl());
  //  Get.lazyPut(() => MessageViewModel());
    Get.lazyPut(() => KhatmaChatViewModel());
    Get.lazyPut(() => QuranViewModel());
    Get.lazyPut(() => MyProfileViewModel());
  }

}