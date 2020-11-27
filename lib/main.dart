import 'package:chatbot_update/bloc/message_bloc.dart';
import 'package:chatbot_update/data/repository/repository.dart';
import 'package:chatbot_update/ui/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => MessageBloc(repository: RepositoryImplementation()),
        child: Chat(),
      ),
    );
  }
}
