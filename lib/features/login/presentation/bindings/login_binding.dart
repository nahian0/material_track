import 'package:get/get.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/login_user.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(LoginUser(AuthRepositoryImpl())));
  }
}
