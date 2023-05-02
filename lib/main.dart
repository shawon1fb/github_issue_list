import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'infrastructure/theme/thems.dart';
import 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();
  var initialRoute = await Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;

  const Main(this.initialRoute, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, widget) => Directionality(
        textDirection: TextDirection.ltr,
        child: EnvironmentsBadge(
          child: GetMaterialApp(
            textDirection: TextDirection.ltr,
            theme: LoginDesign5Theme.lightThemeData,
            fallbackLocale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute,
            getPages: Nav.routes,
            enableLog: true,
            defaultTransition: Transition.fadeIn,
            initialBinding: InitialBindings(),
            builder: (context, Widget? widget) {
              // ScreenUtil.setContext(context);

              return widget ?? const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
}
