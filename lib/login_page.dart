import 'package:flutter/material.dart';
import 'package:mechanics/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20))),
                onPressed: () {
                  if (usernameController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text("Username is empty"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                )
                              ],
                            ));
                  } else if (passwordController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text("Password is empty"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                )
                              ],
                            ));
                  } else if (usernameController.text == "adel" &&
                      passwordController.text == "password") {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomePage()));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content:
                                  const Text("Username or password incorrect"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                )
                              ],
                            ));
                  }
                },
                child: const Text(
                  "Login",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
