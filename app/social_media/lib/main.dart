import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/pages/root_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';
import 'package:social_media/widgets/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* Initialize dotenv
  await dotenv.load();

  final cloudinary_key = await dotenv.get('cloudinary_name');

  //* Configure Cloudinary
  // ignore: deprecated_member_use
  CloudinaryContext.cloudinary =
      await Cloudinary.fromCloudName(cloudName: cloudinary_key);

  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeConfig().init(constraints);

      return MaterialApp(
        navigatorObservers: [routeObserver],
        theme: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Authservice.checkStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: ColorsApp.backgroundColor,
                child: Center(
                  child: Icon(
                    Icons.upload,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final status = snapshot.data!;
              if (status) {
                return RootPage();
              } else {
                return LoginPage();
              }
            } else {
              toastErrorSlide(context, "Error Launching App");
              return SizedBox.shrink();
            }
          },
        ),
      );
    });
  }
}
