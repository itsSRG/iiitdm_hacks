import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: new Text(
          "ResolveIIIT Login",
          textScaleFactor: 1.3,
        ),
      ),
      body: new Container(
        color: Colors.deepPurple,
        padding: const EdgeInsets.all(30.0),
        child: new Column(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
              ),
              height: 200.0,
              alignment: Alignment.center,
              child: new Icon(
                Icons.library_books,
                size: 100.0,
                color: Colors.white,
              ),
            ),
            new TextField(
              controller: new TextEditingController(),
              decoration: new InputDecoration(
                hintText: 'Username',
                filled: true,
                fillColor: Colors.white70,
              ),
            ),
            new TextField(
              controller: new TextEditingController(),
              obscureText: true,
              decoration: new InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white70,
              ),
            ),
            new Container(
              // margin: const EdgeInsets.only( bottom: 150.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: new ElevatedButton(
                      child: new Text("Login"),
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                    
                    ),
                  ),
                  new ElevatedButton(
                    child: new Text("Forgot Password"),
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: new ElevatedButton(
                      child: new Text("Register"),
                      onPressed: onPressed,
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow)),
                    ),
                  ),
                  new ElevatedButton(
                    child: new Text("Continue as Guest"),
                    onPressed: () {Navigator.pushNamed(context, '/forum');},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() {}

}
