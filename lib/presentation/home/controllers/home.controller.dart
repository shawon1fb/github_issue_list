import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../domain/core/exceptions/default.exception.dart';
import '../../../domain/core/pagination/pagination_model.dart';
import '../../../domain/data_model/Issue.model.dart';
import '../../../domain/repository/usecase/github.repository.interface.dart';
import '../../../infrastructure/dal/daos/dto/issue.dto.dart';

class HomeController extends GetxController
    with StateMixin<List<IssueDataModel>> {
  final IGithubRepository _repository;

  HomeController({required IGithubRepository repository})
      : _repository = repository;

  int _page = 0;

  @override
  void onInit() {
    super.onInit();
    getIssueList();
  }

  Future<void> onRefresh() async {
    _page = 0;
    await getIssueList();
  }

  Future<void> getIssueList() async {
    try {
      IssueDto dto = IssueDto(repo: 'flutter', page: _page, owner: 'flutter');
      if (_page == 0) {
        change(value, status: RxStatus.loading());
      } else {
        change(value, status: RxStatus.loadingMore());
      }

      PaginationModel<IssueDataModel> data = await _repository.getIssues(dto);

      _page = data.nextPage;
      List<IssueDataModel> newState = value ?? <IssueDataModel>[];
      if (data.list.isNotEmpty) {
        newState.addAll(data.list);
        for (var item in data.list) {
          _labelList.addAll(item.labels);
        }

        newState = newState.toSet().toList();
      }

      if (newState.isNotEmpty) {
        change(newState, status: RxStatus.success());
      } else {
        change(newState, status: RxStatus.empty());
      }
    } on DefaultException catch (e) {
      change(value ?? <IssueDataModel>[], status: RxStatus.error(e.message));
    } catch (e, t) {
      change(value ?? <IssueDataModel>[], status: RxStatus.error(e.toString()));
      if (kDebugMode) {
        print(e);
        print(t);
      }
    }
  }

  List<String> get labelList => _labelList.toList();
  final Set<String> _labelList = <String>{};

  Future<void> filterIssueByLabel(String label) async {
    List<IssueDataModel> newState = value ?? <IssueDataModel>[];
    if (label.isNotEmpty) {
      newState =
          newState.where((element) => element.labels.contains(label)).toList();
    }
    change(newState, status: RxStatus.success());
  }
}
