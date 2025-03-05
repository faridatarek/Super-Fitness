class DataIntent {
  DataIntent._();




  static String? _userMail;

  static void setUserMail(String mail) => _userMail = mail;

  static String? getUserMail() {
    return _userMail;
  }


}