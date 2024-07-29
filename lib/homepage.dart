import 'package:flutter/material.dart';

import 'package:http/http.dart';


class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _registerUser() async {
    // Create an instance of your API client
    final apiClient = DefaultApi(ApiClient(basePath: "http://your-api-url.com"));

    // Prepare registration request body
    final user = User(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      // Make API call to register user
      final response = await apiClient.registerUser(user);

      // Handle response based on HTTP status code
      if (response.statusCode == 200) {
        // Registration successful, handle accordingly
        print("User registered successfully!");
      } else {
        // Handle other status codes (e.g., 400 for bad request)
        print("Failed to register user: ${response.body}");
      }
    } catch (e) {
      // Handle any exceptions
      print("Error registering user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
