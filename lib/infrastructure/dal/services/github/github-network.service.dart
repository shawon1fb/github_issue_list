import 'dart:convert';

import '../../../../domain/core/abstractions/http_connect.interface.dart';
import '../../../../domain/core/exceptions/default.exception.dart';
import '../../../../domain/core/exceptions/forbidden.exception.dart';
import '../../../../domain/core/exceptions/unauthorized.exception.dart';
import '../../../../domain/core/exceptions/unprocessable.entity.exception.dart';
import '../../daos/dto/issue.dto.dart';
import '../../daos/response/github_issue_response_model.dart';
import '../usecase/github.newwork.service.interface.dart';

class GithubNetworkService extends IGithubNetworkService {
  final IHttpConnect _connect;

  GithubNetworkService({required IHttpConnect connect}) : _connect = connect;

  String get _prefix => 'repos';

  @override
  Future<GithubIssueResponse> getIssueLise(IssueDto dto) async {
    try {
      final response = await _connect.get<GithubIssueResponse>(
        '$_prefix/${dto.owner}/${dto.repo}/issues',
        query: dto.toJson(),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        decoder: (value) {
          print(value);
          return GithubIssueResponse.fromJson(
            value is String ? json.decode(value) : value as List,
          );
        },
      );
      if (response.success) {
        return response.payload!;
      } else {
        switch (response.statusCode) {
          case 401:
            throw UnAuthorizedException(
              message:
                  response.payload?.message ?? 'invalid username or password',
            );
          case 403:
            throw ForbiddenException(
              message:
                  response.payload?.message ?? 'invalid username or password',
            );
          case 422:
            throw UbProcessAbleEntityException(
                message: response.payload?.message ??
                    'UbProcessAbleEntityException');
          case 500:
            throw DefaultException(
              message: response.payload?.message ?? 'Server error',
            );
          default:
            throw DefaultException(
              message: response.payload?.message ??
                  'Error loading data, check your internet!',
            );
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
