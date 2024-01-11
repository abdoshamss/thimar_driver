part of 'bloc.dart';

class FAQSData {
  late final List<FAQSModel> list;

  FAQSData.fromJson(Map<String, dynamic> json) {
    list = List.from(json['data'] ?? [])
        .map((e) => FAQSModel.fromJson(e))
        .toList();
  }
}

class FAQSModel {
  late final int id;
  late final String question;
  late final String answer;

  FAQSModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    question = json['question'] ?? "";
    answer = json['answer'] ?? "";
  }
}
