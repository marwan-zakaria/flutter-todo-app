class User {
  String? id;
  String? fullName;
  String? userName;
  String? email;

  User({this.id, this.fullName, this.userName, this.email});

  User.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'],
          fullName: data?['fullName'],
          userName: data?['userName'],
          email: data?['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
    };
  }
}
