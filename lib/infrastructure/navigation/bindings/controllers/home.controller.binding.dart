import 'package:get/get.dart';

import '../../../../presentation/home/controllers/github.label-controller.dart';
import '../../../../presentation/home/controllers/home.controller.dart';
import '../domains/github-repository.bindings.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    var repo = GithubRepositoryBindings().repository;
    Get.put<HomeController>(
      HomeController(
        repository: repo,
      ),
    );

    Get.lazyPut(
      () => GithubLabelController(
        repository: repo,
      ),
    );
  }
}
