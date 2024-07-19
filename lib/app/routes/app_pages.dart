import 'package:get/get.dart';
import 'package:scratch_project/app/modules/signUp/views/add_picture_view.dart';
import 'package:scratch_project/app/modules/signUp/views/select_gender_view.dart';
import 'package:scratch_project/app/modules/signUp/views/signup_form_screen_view.dart';
import 'package:scratch_project/app/modules/signUp/views/welcome_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onBoarding/bindings/onvboarding_binding.dart';
import '../modules/onBoarding/views/onboarding_view.dart';
import '../modules/signIn/bindings/sign_in_binding.dart';
import '../modules/signIn/views/sign_in_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/birth_date_view.dart';
import '../modules/signUp/views/get_user_location_view.dart';
import '../modules/signUp/views/music_genres_view.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/second_splash_view.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const SPLASH_SCREEN = Routes.SPLASH_SCREEN;
  static const SECOND_SPLASH = Routes.SECOND_SPLASH;
  static const ONBOARDING = Routes.ONBOARDING;
  static const SIGN_UP = Routes.SIGN_UP;
  static const SIGNUP_FORMS = Routes.SIGNUP_FORMS;
  static const DATE_OF_BIRTH = Routes.DATE_OF_BIRTH;
  static const SELECT_GENDER_VIEW = Routes.SELECT_GENDER_VIEW;
  static const MUSIC_GENRE = Routes.MUSIC_GENRE;
  static const ADD_PICTURE = Routes.ADD_PICTURE;
  static const USER_LOCATION = Routes.USER_LOCATION;
  static const WELCOME = Routes.WELCOME;
  static const SIGN_IN = Routes.SIGN_IN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnBoardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_FORMS,
      page: () => SignupFormScreenView(),
    ),
    GetPage(
      name: _Paths.DATE_OF_BIRTH,
      page: () => BirthDateView(),
    ),
    GetPage(
      name: _Paths.SELECT_GENDER_VIEW,
      page: () => SelectGenderView(),
    ),
    GetPage(
      name: _Paths.MUSIC_GENRE,
      page: () => MusicGenresView(),
    ),
    GetPage(
      name: _Paths.ADD_PICTURE,
      page: () => AddPictureView(),
    ),
    GetPage(
      name: _Paths.USER_LOCATION,
      page: () => GetUserLocationView(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SECOND_SPLASH,
      page: () => const SecondSplashView(),
    ),
  ];
}
