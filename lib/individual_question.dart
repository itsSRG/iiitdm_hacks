import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

class Question extends StatefulWidget {
  const Question(
      {Key? key,
      required this.qid,
      required this.question,
      required this.description})
      : super(key: key);
  final String qid;
  final String question;
  final String description;

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final TextEditingController _answerController = TextEditingController();
  int newQNo = 0;
  @override
  Widget build(BuildContext context) {
    // print('The qid is: ');
    // print(widget.qid!.docs.map((DocumentSnapshot document) {
    //       Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //       return data;
    //         }));
    // print('The qid is: ');
    // print(_allAnswers);
    final DocumentReference<Map<String, dynamic>> _answers =
        FirebaseFirestore.instance.collection('questions').doc(widget.qid);
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
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              widget.question,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
            child: Text(
              widget.description,
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          StreamBuilder(
            stream: _answers.snapshots(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.data()!.length - 2,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic>? answers =
                        streamSnapshot.data!.data();
                    newQNo = streamSnapshot.data!.data()!.length - 2;
                    return Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(children: [
                                    answers!['a${index + 1}']
                                                ['approved_by_officials'] ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Container(),
                                    answers['a${index + 1}']
                                                ['approved_by_officials'] ==
                                            true
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : Container(),
                                  ]),
                                  Column(
                                    children: [
                                      Icon(Icons.arrow_upward),
                                      Text((answers['a${index + 1}']['upvote'] -
                                              answers['a${index + 1}']
                                                  ['upvote'])
                                          .toString()),
                                      Icon(Icons.arrow_downward)
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        answers['a${index + 1}']['description'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(height: 25),
                                      Text(
                                        answers['a${index + 1}']['comments'],
                                        style: TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 25),
                                    ],
                                  )
                                ])
                          ]),
                    );
                    // return Card(
                    //   margin: const EdgeInsets.all(10),
                    //   child: ListTile(onTap: (){
                    //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new Question(qid: documentSnapshot.id)));
                    //   },
                    //       title: Text(documentSnapshot['question']),
                    //       subtitle: Text(
                    //         documentSnapshot['question_description'],
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //         softWrap: false,
                    //       )),
                    // );
                  },
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ]),
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
                  'Answer',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            onPressed: () {
              _createOrUpdate();
            },
          ),
        ));
  }

  Future<void> _createOrUpdate() async {
    final DocumentReference<Map<String, dynamic>> _answers =
        FirebaseFirestore.instance.collection('questions').doc(widget.qid);
        print(_answers);
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _answerController,
                  decoration: const InputDecoration(labelText: 'Your Answer'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('Add Answer'),
                  onPressed: () async {
                    print('pressed');
                    final String? answer = _answerController.text;
                    if (answer != null) {
                      _answers
                          .set({
                            'a${newQNo + 1}': {
                              {'description': answer},
                              {'comment': 'No comments Yet'},
                              {'upvote': 0},
                              {'downvote': 0},
                              {'approved_by_officials': false},
                              {'approved_by_questoiner': false}
                            }
                          })
                          .then((value) => print("Successfully Added"))
                          .catchError(
                              (error) => print("Failed to merge data: $error"));
                      ;
                      // Clear the text fields
                      _answerController.text = '';
                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }
}
