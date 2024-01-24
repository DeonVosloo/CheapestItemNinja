class Users
{
  int? id;
  String username;
  String password;
  String email;

  Users(this.id,{required this.username, required this.email, required this.password});

  Users.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        username = result["username"],
        email = result["username"],
        password = result["password"];

  Map<String, Object> toMap() {
    return
      {
        'username': username,
        'email': email,
        'password': password,
      };
  }

}