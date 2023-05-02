import 'package:get/get.dart';

import '../../../../presentation/home/controllers/home.controller.dart';
import '../domains/github-repository.bindings.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        repository: GithubRepositoryBindings().repository,
      ),
    );
  }
}
