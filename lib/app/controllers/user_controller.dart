import 'package:get/get.dart';
import 'package:scratch_project/app/models/user_model.dart';

class UserController extends GetxController {
  final RxString token = ''.obs;
  final user = UserModel(
    id: 0,
    name: '',
    email: '',
    password: '',
    rePassword: '',
    birthdate: '',
    gender: '',
    interests: [],
    profilePicture: '',
    latitude: 0.0,
    longitude: 0.0,
    status: null,
    coins: null,
    verified: null,
  ).obs;
}
