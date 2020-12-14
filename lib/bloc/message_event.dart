import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable{}

class FetchMessageEvent extends MessageEvent{
  final String message;

  final String sender;

  FetchMessageEvent({this.sender,this.message});
  @override
  List<Object> get props => throw UnimplementedError();  
}