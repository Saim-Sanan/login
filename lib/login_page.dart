import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:widgets/dash.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  bool isShow = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Center(
              child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTextBlue("Login"),
                  TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      labelText: "User Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: passWordController,
                    obscureText: isShow,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: isShow
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        print("body: ${body}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(
                      data: body,
                    )));
      } else {
        print(response.body);
      }
    } catch (e) {
      print("error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTextBlue(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.blue,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
