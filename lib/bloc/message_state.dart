import 'package:chatbot_update/data/model/reply_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MessageState extends Equatable {}

class MessageInitialState extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageLoadingState extends MessageState {
  final String message;

  MessageLoadingState({this.message});
  @override
  List<Object> get props => [message];
}

class MessageLoadedState extends MessageState {

  final List<Reply> replies;

  MessageLoadedState({@required this.replies});

  @override
  List<Object> get props => [replies];
}

class MessageErrorState extends MessageState {

  final String message;

  MessageErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}