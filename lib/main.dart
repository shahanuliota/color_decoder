import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'colors.dart';
import 'initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GoogleFonts.config.allowRuntimeFetching = false;
  await Initializer.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  ThemeData _buildRallyTheme() {
    final base = ThemeData.dark();
    return ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: RallyColors.primaryBackground,
        elevation: 0,
      ),
      scaffoldBackgroundColor: RallyColors.primaryBackground,
      primaryColor: RallyColors.primaryBackground,
      focusColor: RallyColors.focusColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: Colors.white,
        color: RallyColors.primaryBackground,
      ),
      textTheme: _buildRallyTextTheme(base.textTheme),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: RallyColors.gray,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: RallyColors.inputBackground,
        focusedBorder: InputBorder.none,
      ),
      visualDensity: VisualDensity.standard,
    );
  }

  double letterSpacingOrNone(double letterSpacing) => kIsWeb ? 0.0 : letterSpacing;

  TextTheme _buildRallyTextTheme(TextTheme base) {
    return base
        .copyWith(
          bodyMedium: GoogleFonts.robotoCondensed(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacingOrNone(0.5),
          ),
          bodyLarge: GoogleFonts.eczar(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            letterSpacing: letterSpacingOrNone(1.4),
          ),
          labelLarge: GoogleFonts.robotoCondensed(
            fontWeight: FontWeight.w700,
            letterSpacing: letterSpacingOrNone(2.8),
          ),
          headlineSmall: GoogleFonts.eczar(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            letterSpacing: letterSpacingOrNone(1.4),
          ),
          titleLarge: GoogleFonts.workSans(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: letterSpacingOrNone(0.18),
            color: ReplyColors.black900,
          ),
        )
        .apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Colors',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      theme: _buildRallyTheme().copyWith(),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
}
