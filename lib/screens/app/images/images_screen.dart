import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:api_app/extentions/context_extention.dart';
import 'package:api_app/get/images_getx_controller.dart';
import 'package:api_app/models/api_response.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/upload_image_screen');
            },
            icon: Icon(Icons.camera),
          ),
        ],
      ),
      body: GetX<ImagesGetxController>(
          init: ImagesGetxController(),
          global: true,
          builder: (ImagesGetxController controller) {
            if (controller.loading.isTrue) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.images.isNotEmpty) {
              return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            controller.images[index].imageUrl,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Container(
                              height: 50,
                              padding: EdgeInsetsDirectional.only(start: 10),
                              width: double.infinity,
                              color: Colors.black45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.images[index].image,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _deleteImage(context, index),
                                    icon: Icon(Icons.delete),
                                    color: Colors.red.shade800,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  'NO IMAGES',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              );
            }
          }),
    );
  }

  void _deleteImage(BuildContext context, int index) async {
    ApiResponse apiResponse = await ImagesGetxController.to.delete(index);
    context.showSnackBar(
      message: apiResponse.message,
      error: !apiResponse.success,
    );
  }
}
