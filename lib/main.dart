import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:api_app/auth/login_screen.dart';
import 'package:api_app/auth/register_screen.dart';
import 'package:api_app/prefs/shared_pref_controller.dart';
import 'package:api_app/screens/app/images/images_screen.dart';
import 'package:api_app/screens/app/images/upload_image_screen.dart';
import 'package:api_app/screens/app/users_screen.dart';
import 'package:api_app/screens/launch_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPrefs();
  runApp(const MyApp());
}

/// API => Application Programming Interface
/// API => Group of HTTP/s requests
/// HTTP => Hyper Text Transfer Protocol
///  => Secured (HTTPs): 443
///  => Not Secured (HTTP): 80
/// ----------
/// HTTP Requests Contents:
///  => Method:
///    => Get
///    => Post
///      => Body
///        => enc-type
///          => x-www-form-url-encoded
///            => Textual (Key => value)
///          => form-data (Key => value)
///            => Textual
///            => Files
///    => PUT/PATCH
///    => DELETE
///  => URI: http://demo-api.mr-dev.tech/api/users
///    => Uniform Request Identifier
///    => URI = URL = URN
///      => URL: Uniform Resource Indicator : demo-api.mr-dev.tech
///      => URN: Uniform Resource Name : api/users
///  ----------
///  => Response Content
///     => Status Code:
///       => (2xx, 3xx, 4xx,5xx)
///       => Success Code:
///         => 200: OK
///         => 201: CREATED
///       => Errors from client
///         => 400: Bad Request
///         => 404: Not found
///         => 405: Method Not Allowed
///         => 401: Unauthorized
///         => 403: Forbidden
///
///     => Response body:
///       => JSON: Java Script Object Notation
///       => Consists of Key:Value
///       => KEY: Always String
///       => value: String,numeric, null, Object, Array
///       => KEY: VALUE
///  ----------------
///  API:
///    HTTP Request
///      1) Contents
///        => Method (GET, POST, PUT, DELETE)
///        => URI (URL + URN)
///      SEND TO SERVER SIDE
///      2) Response
///        => Status Code
///        => Body (JSON, XML)
///        => TIME: ms,s
///        => SIZE: b,kb,mb
///

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/users_screen': (context) => const UsersScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/images_screen' : (context) => const ImagesScreen(),
        '/upload_image_screen' : (context) => const UploadImageScreen(),
      },
    );
  }
}
