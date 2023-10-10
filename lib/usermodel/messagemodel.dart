class MessageModel {
  String? sender;
  String? text;
  bool? seen;
  DateTime? createon;
  MessageModel({this.sender, this.text, this.seen, this.createon});
  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map["sender"];
    text = map["text"];
    seen = map["seen"];
    createon = map["createon"];
  }
  Map<String, dynamic> toMap() {
    return {"sender": sender, "text": text, "seen": seen, "createon": createon};
  }
}
