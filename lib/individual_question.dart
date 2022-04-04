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
  List answersGiven = List<Row>.generate(
    10000,
    (i) => Row(
      children: [
        Column(children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          Icon(Icons.check)
        ]),
        Column(
          children: [
            Icon(Icons.arrow_upward),
            Text('0'),
            Icon(Icons.arrow_downward)
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          children: [
            Text(
              'Answer $i',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Text(
              'comments $i',
              style: TextStyle(fontSize: 20),
            )
          ],
        )
      ],
    ),
  );
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
                    customSearchBar = const Text('My Personal Journal');
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
                'Question Title: Lorem Ipsum',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: answersGiven.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          title: answersGiven[index],
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
