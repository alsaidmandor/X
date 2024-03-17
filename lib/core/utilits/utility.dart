class Utility {
  static String getUserName({
    required String id,
    required String name,
  }) {
    String userName = '';
    if (name.length > 15) {
      name = name.substring(0, 6);
    }
    name = name.split(' ')[0];
    id = id.substring(0, 4).toLowerCase();
    userName = '@$name$id';
    return userName;
  }

  static String getFirstLetterFromUserName(String name) {
    List<String> names = name.split(" ");
    String initials = '';
    for (var i = 0; i < names.length; i++) {
      initials = names[i];
    }
    return initials;
  }
}
