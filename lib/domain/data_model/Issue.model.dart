import 'dart:convert';
import 'package:intl/intl.dart';

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

  String get getDate {
    DateTime dateTime = DateTime.parse(createdAt);

    /// format date dd/month/year

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
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
