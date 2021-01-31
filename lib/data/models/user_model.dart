import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String email;
  final DateTime registerDate;
  final bool status;
  final Image photo;

  User({
    this.id,
    this.username,
    this.email,
    this.registerDate,
    this.status,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> data) => new User(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        registerDate: DateTime.fromMillisecondsSinceEpoch(data['registerDate']),
        status: data['status'] == 1,
        photo: data['photo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'registerDate': registerDate.millisecondsSinceEpoch,
        'status': status ? 1 : 0,
        'photo': photo,
      };
}
