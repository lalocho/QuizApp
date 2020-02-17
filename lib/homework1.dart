import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
/// connects with cheons website to pull the quizzes.
Future<String> getQuiz() async {
  var quiz = getQuizNumber();
  var url = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/?quiz=quiz0''$quiz';
  var response = await http.get(url);
  return response.body;
}

int getQuizNumber(){
  return int.parse(stdin.readLineSync());
}

///gets users answers
String getStringAnswer() {
  var answer = '';
  while(answer == ''){
    print('Enter Your Answer');
    answer = stdin.readLineSync();
  }
  return answer;
}

///Quiz is just a list of questions
class Quiz {
  int Score = 0;
  List<Question> QuizList= [];
  List Answers = [];

  void addQuestion(Question a){
    QuizList.add(a);
  }

  void PrintQuiz() {
    QuizList.forEach((element){
      element.PrintQuestion();
      Answers.add(element.getAnswer());
      Score += element.getPoints();
      print('Your Grade so far: '  '$Score');
    });
    var MaxScore = QuizList.length * 10;
    print('Your Final Grade is: '  '$Score''/'+ MaxScore.toString());
  }

  ///had to use index because there are answers that repeat ie 1
  void PrintAnswers(){
    print('The Correct answers are : ');
    var index = 0;
    Answers.forEach((element){
      print(index.toString() +' : ' + element.toString());
      index++;
    });
  }
}

///questions super class; override some methods if depending on type of subclass
class Question{
 String Query;
 var answer;
 int points = 0;
 void setQuestion(String question){
   Query = question;
 }
 void setAnswer(var answer){
   this.answer = answer;
 }
 String getQuestion(){
   return Query.toString();
 }
 String getAnswer(){
   return answer.toString();
 }
 int getPoints(){
   return points;
 }

 /// check if answers is present in valid answer list
 bool checkAnswer(var input) {
   if(answer.contains(input)){points = 10;return true;}
   return false;
 }

 void PrintQuestion(){
   print(Query);
   checkAnswer(getStringAnswer());
   //print(answer.toString());
 }
}

/// Multiple Choice question subclass
/// overrides printing and checking
class MCQuestion extends Question{
  var options;

  void setOptions(var input){
    options = input;
  }

  @override
  void PrintQuestion(){
    print(Query);
    options.forEach((element){
      print('(' + options.indexOf(element).toString() + ') ' + element.toString());
    });
    //print(options.toString());
    checkAnswer(getStringAnswer());
    //print(answer.toString());
  }

  @override
  bool checkAnswer(var input){
    if( input.toString() == answer.toString()){
      points = 10;
      return true;
    }else {
      return false;
    }
  }
}

///Fill in blank question subclass
class FIBQuestion extends Question{
}