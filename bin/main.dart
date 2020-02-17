import 'package:homework1/homework1.dart' as homework1;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../lib/homework1.dart';
import 'dart:io';
void main(List<String> arguments) async {
  /// dont know why its giving me warning if i fix it breaks.
  homework1.Quiz quiz = new homework1.Quiz();
  var jsonMsg = await getQuiz();
  var decodedQuiz = jsonDecode(jsonMsg);
  /// turning decoded json into a list to iterate through it
  var listQuiz = decodedQuiz['quiz']['question'] as List;
  ///declaring question type to add to quiz list
  listQuiz.forEach((element) {
    var question ;
    switch (element['type']) {
      case 1:
        question = homework1.MCQuestion();
        question.setOptions(element['option']);
        break;
      case 2:
        question = homework1.FIBQuestion();
        break;
      default:
    }
    question.setQuestion(element['stem']);
    question.setAnswer(element['answer'].toString());
    quiz.addQuestion(question);
  });
  quiz.PrintQuiz();
  quiz.PrintAnswers();


}
