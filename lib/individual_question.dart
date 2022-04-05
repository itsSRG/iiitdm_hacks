import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  const Question({Key? key, required this.qid}) : super(key: key);
  final int qid;

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  
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
          padding: EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Is CV a pre-requisite for DIP ?',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 50,
              ),
             Row(
      children: [
        Column(children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          Icon(Icons.check,color: Colors.green,
          )
        ]),
        Column(
          children: [
            Icon(Icons.arrow_upward),
            Text('10'),
            Icon(Icons.arrow_downward)
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No, CV is not a pre-requisite \nfor DIP, more details can be \nfound at the course syllabus \npage.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 25),
            Text(
              'Comment: Thanks !',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            )
          ],
        )
      ]),
      SizedBox(height: 25),
      Row(
      children: [
        SizedBox(width: 24,),
        Column(
          children: [
            Icon(Icons.arrow_upward),
            Text('-1'),
            Icon(Icons.arrow_downward)
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yes, I believe that\'s true.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
          width: 50,
        ),
            Text(
              'Comment: The opposite was \ndiscussed at the meeting, this \ninfo is false !',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 25),
          ],
        )
      ])
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
                  'Write an Answer',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            onPressed: () {},
          ),
        ));
  }
}