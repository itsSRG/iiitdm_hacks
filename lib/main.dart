import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'forum_detail.dart';
import 'login/login.dart';
import 'all_questions.dart';
import 'individual_question.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(new MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ResolveIIIT-DM',
      routes: <String, WidgetBuilder>{
         '/':      (BuildContext context) => new LoginPage(),
         '/questions': (BuildContext context) => new Questions(),
         '/forum/1': (BuildContext context) => new ForumDetailPage(),
         '/individual_question': (BuildContext context) => new Question(qid: '12'),
      },
      initialRoute: '/',
    );
  }
}
