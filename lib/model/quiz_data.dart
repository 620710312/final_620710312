class QuizItem {
  final String image;
  final String answer;
  final List choice;

  QuizItem({
    required this.image,
    required this.answer,
    required this.choice,
  });
  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(
      image:  json["image"],
      answer:   json["answer"],
      choice:   (json['choice_list'] as List).map((choice) => choice).toList() ,
    );
  }
}