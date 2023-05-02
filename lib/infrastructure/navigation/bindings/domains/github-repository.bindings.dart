import 'package:get/get.dart';

import '../../../../domain/core/abstractions/http_connect.interface.dart';
import '../../../../domain/core/http_client/dia.http.client.dart';
import '../../../../domain/repository/github/githut.repository.dart';
import '../../../../domain/repository/usecase/github.repository.interface.dart';
import '../../../dal/dio.connect.dart';
import '../../../dal/services/github/github-network.service.dart';
import '../../../dal/services/usecase/github.newwork.service.interface.dart';

class GithubRepositoryBindings {
  late IGithubRepository _repository;

  IGithubRepository get repository => _repository;

  GithubRepositoryBindings() {
    /// dio client
    final AppHttpClient getHttpClient = Get.find<AppHttpClient>();
    final IHttpConnect connect = DioConnect(connect: getHttpClient.httpClient);

    final IGithubNetworkService service =
        GithubNetworkService(connect: connect);

    _repository = GithubRepository(service: service);
  }
}
