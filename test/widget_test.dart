// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_issue_list/domain/core/pagination/pagination_model.dart';
import 'package:github_issue_list/domain/data_model/Issue.model.dart';
import 'package:github_issue_list/domain/repository/usecase/github.repository.interface.dart';
import 'package:github_issue_list/infrastructure/dal/daos/dto/issue.dto.dart';
import 'package:github_issue_list/infrastructure/navigation/bindings/domains/github-repository.bindings.dart';
import 'package:github_issue_list/initializer.dart';

import 'package:github_issue_list/main.dart';

void main() {
  test('github issueList', () async {
    await Initializer.testInit();

    IGithubRepository repository = GithubRepositoryBindings().repository;
    IssueDto dto = IssueDto(repo: 'html', page: 1, owner: 'dart-lang');
    PaginationModel<IssueDataModel> data = await repository.getIssues(dto);
    print(data.list.length);
    print('length => ${data.list.length}');
    for (var item in data.list) {
      print(item.title);
    }
    expect(data.list.isNotEmpty, true);
  });
}
