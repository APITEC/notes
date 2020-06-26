import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List notes = [];

  final List colors = [
    Colors.orange[200],
    Colors.pink[200],
    Colors.lightGreen[200],
    Colors.red[200],
    Colors.purple[200],
    Colors.deepPurple[200],
    Colors.indigo[200],
    Colors.blue[200],
    Colors.teal[200],
    Colors.yellow[200],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Notes',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 40,
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: notes.length > 0
            ? StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: notes.length,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      var updatedNote = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Note(
                            title: notes[index]['title'],
                            note: notes[index]['note'],
                          ),
                        ),
                      );
                      setState(() {
                        notes[index]['title'] = updatedNote['title'];
                        notes[index]['note'] = updatedNote['note'];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            notes[index]['title'],
                            style: TextStyle(
                              color: Colors.grey[850],
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              notes[index]['note'],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[850],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 12,
                                ),
                              ),
                              Text(
                                'May 21 2020',
                                style: TextStyle(
                                  color: Colors.grey[850],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (item) {
                  return StaggeredTile.fit(1);
                },
              )
            : Center(
                child: Text(
                  'You have not created any notes!',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newNote = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => Note()));
          setState(() {
            notes.add({'title': newNote['title'], 'note': newNote['note']});
          });
        },
        backgroundColor: Colors.grey[850],
        child: Icon(
          Icons.edit,
          size: 25,
        ),
      ),
    );
  }
}

class Note extends StatefulWidget {
  final title;
  final note;
  Note({this.title, this.note});
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.title;
    note.text = widget.note;
    print(note.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: title,
                cursorColor: Colors.grey[300],
                cursorWidth: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: null,
              ),
              TextField(
                controller: note,
                cursorColor: Colors.grey[300],
                cursorWidth: 3,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write something...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(title.text);
          print(note.text);
          Navigator.pop(context, {'title': title.text, 'note': note.text});
        },
        backgroundColor: Colors.grey[850],
        child: Icon(Icons.save),
      ),
    );
  }
}
