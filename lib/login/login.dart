import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iiitdm_hacks/all_questions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<String> signInWithGoogle() async {
//   // Initialize Firebase
//   await Firebase.initializeApp();
//   User? user;

//   // The `GoogleAuthProvider` can only be used while running on the web 
//   GoogleAuthProvider authProvider = GoogleAuthProvider();

//   try {
//     final UserCredential userCredential =
//         await _auth.signInWithPopup(authProvider);

//     user = userCredential.user;
//   } catch (e) {
//     print(e);
//   }

//   if (user != null) {
//     uid = user.uid;
//     name = user.displayName;
//     userEmail = user.email;
//     imageUrl = user.photoURL;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('auth', true);
//   }

//   return user;
// }

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _userObj = account;
//       });
//       // if (_userObj != null) {
//       //   _handleGetContact();
//       // }
//     });
//     _googleSignIn.signInSilently();
//   }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resolveiiit DM")),
      body: Container(
        child: _isLoggedIn
            ? Questions()
            : Center(
                child: ElevatedButton(
                  child: Text("Login with Google"),
                  onPressed: () {
                    _googleSignIn.signIn().then((userData) {
                      _isLoggedIn = true;
                      _userObj = userData!;
                      Navigator.of(context).pushNamedAndRemoveUntil('/questions', (route) => false);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ),
      ),
    );
  }
}
