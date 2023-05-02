import 'dart:convert';

class IssueDto {
  int page;
  int perPage;
  String sort;
  String direction;
  String repo;
  String owner;

  IssueDto({
    required this.owner,
    required this.repo,
    required this.page,
    this.perPage = 15,
    this.sort = 'updated',
    this.direction = 'asc',
  });

  Map<String, String> toJson() {
    return {
      'page': page.toString(),
      'per_page': perPage.toString(),
      'sort': sort,
      'direction': direction,
    };
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toJson());
  }
}
