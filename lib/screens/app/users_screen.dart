import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:api_app/api/auth_api_controller.dart';
import 'package:api_app/api/users_api_controller.dart';
import 'package:api_app/extentions/context_extention.dart';
import 'package:api_app/models/api_response.dart';
import 'package:api_app/models/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
           IconButton(
               onPressed: () async{
                 ApiResponse apiResponse = await AuthApiController().logout();
                 context.showSnackBar(
                     message: apiResponse.message,
                     error: !apiResponse.success,
                 );
                 if(apiResponse.success){
                   Navigator.pushReplacementNamed(context, '/login_screen');
                 }
               },
               icon: Icon(Icons.logout),
           ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/images_screen');
            },
            icon: Icon(Icons.image_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: UsersApiController().getUsers(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasData && snapshot.data!.isNotEmpty){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(snapshot.data![index].image),
                    ),
                    title: Text(snapshot.data![index].firstName),
                    subtitle: Text(snapshot.data![index].email),
                  );
                });
          }else {
            return Center(
              child: Text(
                'NO DATA',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),),);
          }
        },
      ),
    );
  }
}
