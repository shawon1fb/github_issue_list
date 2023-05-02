import 'dart:convert';

class IssueDataModel {
  String title;
  String issueBody;
  String createdAt;
  String author;
  int id;
  List<String> labels;

  IssueDataModel({
    required this.title,
    required this.issueBody,
    required this.createdAt,
    required this.author,
    required this.labels,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'issueBody': issueBody,
      'createdAt': createdAt,
      'author': author,
      'labels': labels,
      'id': id,
    };
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent(' ').convert(toMap());
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;

  @override
  bool operator ==(var other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType && other.hashCode == hashCode);
}
