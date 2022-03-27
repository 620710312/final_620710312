import 'dart:async';

import 'package:final_620710312/api/api.dart';
import 'package:final_620710312/model/quiz_data.dart';
import 'package:flutter/material.dart';


class GamePages extends StatefulWidget {

  const GamePages({Key? key}) : super(key: key);

  @override
  _GamePagesState createState() => _GamePagesState();
}

class _GamePagesState extends State<GamePages> {
    List<QuizItem>? quiz;
    int count = 0;
    int wrong = 0;
    String message = "";

    @override
    void initState() {
      super.initState();
      _fetch();
    }

    void _fetch() async {
      List qlist = await api().fetch('quizzes');
      setState(() {
        quiz = qlist.map((item) => QuizItem.fromJson(item)).toList();
      });
    }

    void guess(String choice) {
      setState(() {
        if (quiz![count].answer == choice) {
          message = "เก่งมาก กล้ามาก ขอบใจ";
        } else {
          message = "ไม่ใช่ข้อนี้";
        }
      });
      Timer timer = Timer(Duration(seconds:3),(){
        setState(() {
          message = "";
          if (quiz![count].answer == choice) {
            count++;
          } else {
            wrong++;
          }
        });
      });
    }

    Widget printGuess() {
      if (message.isEmpty) {
        return SizedBox(height: 20, width: 10);
      } else if (message == "เก่งมาก<3") {
        return Text(message);
      } else {
        return Text(message);
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: quiz != null && count < quiz!.length-1
            ? buildQuiz()
            : quiz != null && count == quiz!.length-1
            ? buildTryAgain()
            : const Center(child: CircularProgressIndicator()),
      );
    }

    Widget buildTryAgain() {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('End Game'),
              Text('ทายผิด ${wrong} ครั้ง'),
            ],
          ),
        ),
      );
    }

    Padding buildQuiz() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(quiz![count].image, fit: BoxFit.cover),
              Column(
                children: [
                  for (int i = 0; i < quiz![count].choice.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () =>
                                  guess(quiz![count].choice[i].toString()),
                              child: Text(quiz![count].choice[i]),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              printGuess(),
            ],
          ),
        ),
      );
    }
  }

