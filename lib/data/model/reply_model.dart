class ReplyArray {
  final List<Reply> replies;

  ReplyArray({
    this.replies,
});

  factory ReplyArray.fromJson(List<dynamic> parsedJson) {

    List<Reply> listreply = new List<Reply>();
    listreply = parsedJson.map((reply)=>Reply.fromJson(reply)).toList();

    return new ReplyArray(
      replies: listreply
    );
  }
}

class Reply{
  final String recipientId;
  final String text;

  Reply({
    this.recipientId,
    this.text
}) ;

  factory Reply.fromJson(Map<String, dynamic> json){
    return new Reply(
      recipientId: json['recipient_id'],
      text: json['text']
    );
  }

}