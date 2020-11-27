import 'package:chatbot_update/bloc/message_bloc.dart';
import 'package:chatbot_update/bloc/message_event.dart';
import 'package:chatbot_update/bloc/message_state.dart';
import 'package:chatbot_update/data/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  MessageBloc messageBloc;
  List<Message> messagesGlobal=[];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messageBloc = BlocProvider.of<MessageBloc>(context);
    messageBloc.add(FetchMessageEvent(message: "Hello how are you",sender: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1d2d50),
      appBar: AppBar(
        backgroundColor: Color(0xff1d2d50),
        title: Text(
          "BITS-Queries",
          style: TextStyle(
            color: Color(0xffF5F7DC),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocBuilder<MessageBloc, MessageState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is MessageInitialState) {
              return _buildCollumn(messagesGlobal);
            } else if (state is MessageLoadingState) {
              messagesGlobal.add(Message(text: state.message,isMe: true));
              messagesGlobal.add(Message(isMe: false, text: "loading"));
              return _buildCollumn(messagesGlobal);
            } else if (state is MessageLoadedState) {
              List<Message> newmessage = state.replies
                  .map((e) => Message(text: e.text, isMe: false))
                  .toList();
              if (messagesGlobal.isNotEmpty) messagesGlobal.removeLast();
              messagesGlobal.addAll(newmessage);
              return _buildCollumn(messagesGlobal);
            } else if (state is MessageErrorState) {
              return _buildError(state.message);
            } else {
              return Text("Lol");
            }
          },
        ),
      ),
    );
  }

  _buildError(String error) {
    return Scaffold(
      body: Center(
        child: Text("Error : $error"),
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              right: 8.0,
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        color: isMe ? Color(0xff1e5f74) : Color(0xFF133b5c),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.text,
            style: TextStyle(
              color: Color(0xffF5F7DC),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    return msg;
  }

  _buildCollumn(List<Message> messages) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff0F0326),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: ListView.builder(
                reverse: false,
                padding: EdgeInsets.only(top: 15.0),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  Message message = messages[index];
                  bool isMe = message.isMe;
                  if (message.text == "loading")
                    return CircularProgressIndicator();
                  else
                    return _buildMessage(message, isMe);
                },
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 90.0,
          color: Color(0xff1d2d50),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  style: TextStyle(
                    color: Color(0xffF5F7DC),
                  ),
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Send a message...',
                      hintStyle: TextStyle(
                        color: Color(0xff1e5f74),
                      )),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 25.0,
                  color: Color(0xffF5F7DC),
                  onPressed: () {
                    messageBloc.add(FetchMessageEvent(
                        message: controller.text, sender: ""));
                  }),
            ],
          ),
        ),
      ],
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
