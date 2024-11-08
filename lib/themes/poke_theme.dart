import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokeTheme {

  static Color background = const Color.fromRGBO(251, 255, 249, 1);
  static Color red = const Color.fromRGBO(235, 54, 54, 1);
  static Color green = const Color.fromRGBO(25, 121, 23, 1);
  static Color black = const Color.fromRGBO(51, 51, 51, 1);
  static Color placeholder = const Color.fromRGBO(126, 126, 126, 1);
  static Color white = const Color.fromRGBO(255, 255, 255, 1);
  static Color azure = const Color.fromRGBO(54, 169, 235, 1);
  static Color text = const Color.fromRGBO(51, 51, 51, 1);
  static Color azureDark = const Color.fromRGBO(64, 103, 132, 1);
  static Color redBlood = const Color.fromRGBO(185, 40, 40, 1);
  static Color inputBackgroundSearch = const Color.fromRGBO(236, 243, 245, 1);

  // Types Colors

  static Color normal = const Color.fromRGBO(168, 168, 125, 1);
  static Color fire = const Color.fromRGBO(225, 134, 68, 1);
  static Color water = const Color.fromRGBO(112, 143, 233, 1);
  static Color electric = const Color.fromRGBO(242, 209, 84, 1);
  static Color grass = const Color.fromRGBO(139, 198, 96, 1);
  static Color ice = const Color.fromRGBO(166, 214, 215, 1);
  static Color fighting = const Color.fromRGBO(177, 61, 49, 1);
  static Color poison = const Color.fromRGBO(148, 70, 155, 1);
  static Color ground = const Color.fromRGBO(219, 193, 117, 1);
  static Color flying = const Color.fromRGBO(162, 143, 231, 1);
  static Color psychic = const Color.fromRGBO(227, 98, 134, 1);
  static Color bug = const Color.fromRGBO(170, 182, 66, 1);
  static Color rock = const Color.fromRGBO(179, 160, 74, 1);
  static Color ghost = const Color.fromRGBO(106, 87, 145, 1);
  static Color dragon = const Color.fromRGBO(103, 58, 235, 1);
  static Color dark = const Color.fromRGBO(108, 89, 74, 1);
  static Color steel = const Color.fromRGBO(159, 159, 159, 1);
  static Color fairy = const Color.fromRGBO(231, 184, 189, 1);

  // Fonts

  static double headlineFontSize = 14;
  static double labelLargeFontSize = 14;
  static double headLineMediumFontSize = 24;
  static double fontSize = 14;

  static ThemeData lightTheme = ThemeData(
    /* HACK TO REMOVE NAVIGATION BAR RIPPLE EFFECT */
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    /* THEME START */
    scaffoldBackgroundColor: background,
    fontFamily: 'GoogleSans',
    brightness: Brightness.light,
    primaryColor: text,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.notoSans(
        fontSize: headlineFontSize,
        fontWeight: FontWeight.bold
      ),
      headlineMedium: GoogleFonts.notoSans(
        fontSize: headLineMediumFontSize,
        fontWeight: FontWeight.w600
      ),
      headlineSmall: GoogleFonts.notoSans(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.notoSans(
        fontSize: headlineFontSize
      ),
      bodyMedium: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w300
      ),
      bodySmall: GoogleFonts.notoSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w300
      ),
      displayLarge: GoogleFonts.notoSans(
        fontSize: 28,
        fontWeight: FontWeight.w700
      )
    ),

    /* APP BAR */

    appBarTheme: AppBarTheme(
      backgroundColor: PokeTheme.white,
      foregroundColor: PokeTheme.text,
      elevation: 0.2,
      scrolledUnderElevation: 0.2,

      shadowColor: PokeTheme.azure,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: PokeTheme.text,
        fontSize: 24
      ),
      centerTitle: true
    ),

    /* BUTTONS */

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(azure),
        foregroundColor: WidgetStateProperty.all(white),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.notoSans(
            fontSize: labelLargeFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
        enableFeedback: true
      ),
    ),

    /* TEXTFORMFIELD */

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputBackgroundSearch,
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      hintStyle: GoogleFonts.notoSans(
        fontSize: fontSize,
        color: placeholder,
        fontWeight: FontWeight.w300
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: redBlood,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: redBlood,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: text,
    ),

    /* NAVIGATIONBAR */
    navigationBarTheme: NavigationBarThemeData(
      height: 49,
      elevation: 0.2,
      shadowColor: PokeTheme.azure,
      indicatorColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return GoogleFonts.notoSans(
          fontSize: 12,
          color: azureDark
        );
      })
    ),

    /* FLOATINGACTIONBUTTON */
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: azure
    )
  );

  static snackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
        ),
      )
    );
  }

}