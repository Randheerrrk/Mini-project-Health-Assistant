
enum UserType{
  User,
  Bert
}

class UserMessage {
  String text;
  UserType user;
  int id;

  UserMessage(String val,UserType type){
      this.text = val;
      this.user =type;
  }
}