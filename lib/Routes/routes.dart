// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mygovern/Core/Constant/string.dart';
import 'package:mygovern/Screens/Details_Screen/category_details.dart';
import 'package:mygovern/Screens/Details_Screen/detailspage.dart';
import 'package:mygovern/Screens/Details_Screen/stepper_proc.dart';
import 'package:mygovern/Screens/Details_Screen/view_all_doc.dart';
import 'package:mygovern/Screens/FeedBackForm/feedback.dart';
import 'package:mygovern/Screens/Home_Screen/homepage.dart';
import 'package:mygovern/Screens/Request_Document/request_doc_form.dart';
import 'package:mygovern/Screens/Request_Document/request_doc_list.dart';
import 'package:mygovern/Screens/Splash_Screen/onboarding/onboarding_screen.dart';
import 'package:mygovern/Screens/category_for_document/cat_for_doc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/Authentication/Auth_With_Number/auth_number.dart';
import '../Screens/Authentication/Auth_With_Number/forgotpass.dart';
import '../Screens/Authentication/Auth_With_Number/otp_verification.dart';
import '../Screens/Authentication/signinpage.dart';
import '../Screens/Authentication/signuppage.dart';
import '../Screens/Document_pdf_generator/invoices.dart';
import '../Screens/Splash_Screen/Splash/splashscreen.dart';

class Routes {
  late int initScreen;
  Future<void> checkForOnBordScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt("initScreen")!;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    switch (settings.name) {
      //splash screens
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case onboardingScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      case singInScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignInpage());

      case signUpScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignupPage());
      // main screens
      case homepageScreenRoute:
        return MaterialPageRoute(builder: (context) => const HomePage());

      // details screens
      case viewalldocScreenRoute:
        return MaterialPageRoute(builder: (context) => const ViewAllDoc());

      case stepperdetailsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => DocStepperView(
                  idname: args,
                ));

      case categorydetailsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => CategoryDetails(
                  data: args,
                ));
      case catfordocScreenRoute:
        return MaterialPageRoute(
            builder: (context) => CatforDoc(documentname: args, id: args));
      case NumberauthScreenRoute:
        return MaterialPageRoute(builder: (context) => const NumberAuth());

      case ForgotpassScreenRoute:
        return MaterialPageRoute(builder: (context) => const ForgotPass());
      case stepperprocessScreenRoute:
        return MaterialPageRoute(
            builder: (context) => StepperPross(
                  idname: args,
                ));
      case otpverificationScreenRoute:
        return MaterialPageRoute(builder: (context) {
          return VerifyPhoneNumberScreen(
            // Name: args,
            // Email: args,
            // phoneNumber: args,
            phoneNumber: args,
          );
        });
      case requestDocListScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const RequestDocumentList());
      case requestDocFormScreenRoute:
        return MaterialPageRoute(builder: (context) => RequestDocForm(args));

      case invoiceScreenRoute:
        return MaterialPageRoute(builder: (context) => InvoicePage());
      case FeedbackScreenRoute:
        return MaterialPageRoute(builder: (context) => FormFour());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
