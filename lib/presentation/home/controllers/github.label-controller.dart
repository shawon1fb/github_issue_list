import 'package:get/get.dart';

import '../../../domain/repository/usecase/github.repository.interface.dart';

class GithubLabelController extends GetxController {
  GithubLabelController({required IGithubRepository repository})
      : _repository = repository;

  final IGithubRepository _repository;

  List<String> getLabels() {
    return [];
  }
}
