import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthRemoteDatasourceImpl {
  // Login using Fake Store API
  Future<User> login(String username, String password) async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] as String;

        // Fetch user details to populate the User model
        final userResponse = await http.get(
          Uri.parse('https://fakestoreapi.com/users?username=$username'),
        );
        if (userResponse.statusCode == 200) {
          final users = jsonDecode(userResponse.body) as List;
          if (users.isNotEmpty) {
            print(users[0]);
            // Create a User object and include the token
            final user = User.fromJson(users[0]).copyWithToken(token);
            return user;
          } else {
            throw Exception('User not found for username: $username');
          }
        } else {
          throw Exception(
            'Failed to fetch user details: ${userResponse.statusCode} - ${userResponse.body}',
          );
        }
      } else {
        throw Exception(
          'Login failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  // Simulate signup (Fake Store API doesn't persist new users)
  Future<User> signUp(User user) async {
    // Since Fake Store API doesn't persist new users, we'll simulate signup
    // by directly logging in with the provided username and password.
    final loggedInUser = await login(user.username, user.password);
    // Update the user with the details from the signup form, keeping the token
    return user.copyWithToken(loggedInUser.token);
  }
}
