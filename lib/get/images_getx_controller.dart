import 'package:get/get.dart';
import 'package:api_app/api/images_api_controller.dart';
import 'package:api_app/models/api_response.dart';
import 'package:api_app/models/student_image.dart';

class ImagesGetxController extends GetxController{

  static ImagesGetxController get to => Get.find<ImagesGetxController>();
  RxBool loading = false.obs;
  RxList<StudentImage> images = <StudentImage>[].obs;
  final ImagesApiController _apiController = ImagesApiController();

  @override
  void onInit(){
    read();
    super.onInit();
  }

  Future<ApiResponse> upload(String path) async{
    ApiResponse<StudentImage> apiResponse = await _apiController.uploadImage(path);
    if(apiResponse.success && apiResponse.object != null){
      images.add(apiResponse.object!);
    }
    return apiResponse;
  }

  void read() async{
    loading.value= true;
    images.value = await _apiController.read();
    loading.value = false;
  }

  Future<ApiResponse> delete(int index) async{
    ApiResponse apiResponse = await _apiController.delete(images[index].id);
    if(apiResponse.success){
      images.removeAt(index);
    }
    return apiResponse;
  }


}