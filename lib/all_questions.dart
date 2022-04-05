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
  Widget customSearchBar = const Text('Resolveiiit DM');

  final CollectionReference _questionsAsked =
      FirebaseFirestore.instance.collection('questions');

  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
          stream: _questionsAsked.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                        title: Text(documentSnapshot['question']),
                        subtitle: Text(
                          documentSnapshot['question_description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        )),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
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
        ));
  }

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    var data = await FirebaseFirestore.instance
        .collection("questions")
        .doc("ZCKqb4Bwf3I4osjDiegi");

    return data.get();
  }
}
