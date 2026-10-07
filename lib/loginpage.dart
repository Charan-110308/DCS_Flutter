import 'package:flutter/material.dart';
import 'package:mymoviezz/homepage.dart';
class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(255, 225, 230, 141),
          centerTitle: true,
          title:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "MyMoviez",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8,  
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Explore the World of Movies",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          )
        ),
        body: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start ,
            children: [
              SizedBox(
                height: 150,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                 print("Username: ${
                  usernameController.text
                  }"
                  );
                 print("Password: ${
                  passwordController.text
                  }"
                  );
                  if(usernameController.text == "admin" && passwordController.text == "admin")
                  {
                    Navigator.pushReplacement(
                      context,
                       MaterialPageRoute(
                        builder: (context) => homepage(),
                        ),
                    );
                  }
                  else
                  {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Login Failed"),
                        content: Text("Invalid username or password."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text("LOGIN"),
              ),
            ],
          ),
        ),
      );
  }
}
