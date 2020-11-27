import 'package:chatbot_update/bloc/message_event.dart';
import 'package:chatbot_update/bloc/message_state.dart';
import 'package:chatbot_update/data/model/reply_model.dart';
import 'package:chatbot_update/data/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent,MessageState>{

  Repository repository;

  MessageBloc({@required this.repository}) : super(null);

  MessageState get initialState => MessageInitialState();

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async*{
    if(event is FetchMessageEvent){
      yield MessageLoadingState(message: event.message);
      try{
        List<Reply> replies = await repository.getreplies(event.sender, event.message);
        yield MessageLoadedState(replies: replies);
      }
      catch(e){
        yield MessageErrorState(message: e.toString());
      }
    }
  }
  
}