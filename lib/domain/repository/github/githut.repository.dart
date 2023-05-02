import '../../../infrastructure/dal/daos/dto/issue.dto.dart';
import '../../../infrastructure/dal/daos/response/github_issue_response_model.dart';
import '../../../infrastructure/dal/services/usecase/github.newwork.service.interface.dart';
import '../../core/pagination/pagination_model.dart';
import '../../data_model/Issue.model.dart';
import '../usecase/github.repository.interface.dart';

class GithubRepository extends IGithubRepository {
  final IGithubNetworkService _service;

  GithubRepository({required IGithubNetworkService service})
      : _service = service;

  @override
  Future<PaginationModel<IssueDataModel>> getIssues(IssueDto dto) async {
    try {
      GithubIssueResponse response = await _service.getIssueLise(dto);
      List<IssueDataModel> list = <IssueDataModel>[];

      List<GithubIssueResponseModel> resList = response.list;

      for (var item in resList) {
        List<Labels> l = item.labels ?? <Labels>[];
        List<String> labels = l.map((e) => e.name ?? '').toList();
        var m = IssueDataModel(
          title: item.title!,
          issueBody: item.body??'',
          createdAt: item.createdAt!,
          author: item.user!.login!,
          labels: labels,
          id: item.id!,
        );
        list.add(m);
      }

      return PaginationModel(
        page: dto.page,
        totalPages: dto.page + 1,
        list: list,
      );
    } catch (e) {
      rethrow;
    }
  }
}
