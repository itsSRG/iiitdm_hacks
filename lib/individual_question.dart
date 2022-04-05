import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert' show json;

class Question extends StatefulWidget {
  const Question({Key? key, required this.qid}) : super(key: key);
  final String qid;

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Revealiiit DM');

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: _questionsAsked.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                            title: Text(documentSnapshot.toString()
                            ),
                            subtitle: Text(
                              documentSnapshot.data().toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            )),
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
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
                  'Write an Answer',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            onPressed: () {},
          ),
        ));
  }

//   Future<void> getCategoriesCollectionFromFirebase() async {
//     DocumentSnapshot snapshot = await _questionsAsked.doc('categories').get();
//     if (snapshot.exists) {
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//       var answerData = data[widget.qid] as List<dynamic>;
//       answerData.forEach((catData) {
//         var answer = {
//           'approved_by_officials':
//               json.decode(catData)['approved_by_officials'],
//           'approved_by_questoiner':
//               json.decode(catData)['approved_by_questoiner'],
//           'comments': json.decode(catData)['comments'],
//           'description': json.decode(catData)['description'],
//           'downvote': json.decode(catData)['downvote'],
//           'upvote': json.decode(catData)['upvote']
//         };

//         print(answer);
//       });
//     }
//   }
}
