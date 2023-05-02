import '../../../infrastructure/dal/daos/dto/issue.dto.dart';
import '../../core/pagination/pagination_model.dart';
import '../../data_model/Issue.model.dart';

abstract class IGithubRepository {
  Future<PaginationModel<IssueDataModel>> getIssues(IssueDto dto);
}
