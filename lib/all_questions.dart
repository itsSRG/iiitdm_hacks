import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  List questionsAsked =
      List<String>.generate(10000, (i) => 'Quesition $i\nDescription $i');
  // @override
  // void initState() {
  //   super.initState();
    
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: getData(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Something Went Wrong');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> dataMap = snapshot.data!.data() as Map<String, dynamic>;
          print(dataMap);
          // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          
          return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('Resolveiiit DM');
                  }
                });
              },
              icon: customIcon,
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'All Questions',
                style: TextStyle(fontSize: 25),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: questionsAsked.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          title: Text(questionsAsked[index]),
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/individual_question');
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          width: 80.0,
          height: 80.0,
          child: FloatingActionButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(Icons.add_circle_outline_outlined),
                Text(
                  'Ask a Question',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            onPressed: () {},
          ),
        )
        );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
    
  }

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    var data = await FirebaseFirestore.instance
        .collection("questions")
        .doc("ZCKqb4Bwf3I4osjDiegi");
    
    return data.get();
  }


}

