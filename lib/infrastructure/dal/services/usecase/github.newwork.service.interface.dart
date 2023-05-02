import '../../daos/dto/issue.dto.dart';
import '../../daos/response/github_issue_response_model.dart';

abstract class IGithubNetworkService {
  Future<GithubIssueResponse> getIssueLise(IssueDto dto);
}
