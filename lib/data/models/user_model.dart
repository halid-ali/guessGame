class User {
  final int id;
  final String username;
  final String email;
  final DateTime registerDate;
  final bool status;

  User({
    this.id,
    this.username,
    this.email,
    this.registerDate,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> data) => new User(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        registerDate: DateTime.fromMillisecondsSinceEpoch(data['registerDate']),
        status: data['status'] == 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'registerDate': registerDate.millisecondsSinceEpoch,
        'status': status ? 1 : 0,
      };
}
