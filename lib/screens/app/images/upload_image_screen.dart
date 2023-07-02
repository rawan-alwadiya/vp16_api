import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:api_app/extentions/context_extention.dart';
import 'package:api_app/get/images_getx_controller.dart';
import 'package:api_app/models/api_response.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  double? _progressValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            color: Colors.green,
            minHeight: 6,
            value: _progressValue,
          ),
          _pickedImage != null
              ? Expanded(child: Image.file(File(_pickedImage!.path)))
              : Expanded(
                child: IconButton(
                  onPressed: ()=> _pickImage(),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 50,
                  ),
          ),
              ),
          ElevatedButton.icon(
          onPressed: ()=> _performUpload(),
          label: const Text('UPLOAD'),
          icon: const Icon(Icons.cloud_upload),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage() async{
    XFile? imageFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if(imageFile != null){
      setState((){
        _pickedImage = imageFile;
      });
    }
  }

  void _performUpload(){
    if(_checkData()){
      _uploadImage();
    }
  }

  bool _checkData(){
    if(_pickedImage != null){
      return true;
    }
    context.showSnackBar(message: 'Pick image to upload', error: true);
    return false;
  }

  void _uploadImage() async{
    _changeProgress();
    ApiResponse apiResponse = await ImagesGetxController.to.upload(_pickedImage!.path);
    _changeProgress(progress: apiResponse.success? 1 : 0);
    context.showSnackBar(
        message: apiResponse.message,
        error: !apiResponse.success,
    );
  }

  void _changeProgress({double? progress}){
    setState(()=> _progressValue = progress);
  }
}
