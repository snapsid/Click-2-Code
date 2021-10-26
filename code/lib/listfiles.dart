import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'myhome.dart';

class MyListFiles extends StatefulWidget {
  const MyListFiles({Key key}) : super(key: key);

  static String data = "a";
  static String filename = "a";

  @override
  _MyListFilesState createState() => _MyListFilesState();
}

class _MyListFilesState extends State<MyListFiles> {
  String ip;
  List files = [];
  var language = MyHome.language;

  void initApp() async {
    var url = Uri.parse(
        'http://${ip}/cgi-bin/listfiles/listfiles.py?name=sidd&lan=$language');
    try {
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });
      var code = response.statusCode;
      print(code);
      if (code == 200) {
        var body = response.body;
        print(body);

        setState(() {
          files = body.split('\n');
          files.remove('');
          files.remove('a.sh');
          files.remove('a');
          files.removeWhere((element) => element.toString().endsWith('.out'));
        });
      } else {
        print('invalid IP');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    ip = MyIp.ip_public;
    initApp();

    super.initState();
  }

  myToast(mymsg, color) {
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        webPosition: "center",
        fontSize: 16.0);
  }

  onRenameFolder(index) {
    var name = "";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Rename Folder'),
            contentPadding: EdgeInsets.only(top: 20, left: 24, right: 24),
            titlePadding: EdgeInsets.only(top: 24, left: 24, right: 24),
            content: TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                hintText: "Enter Folder Name",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    if (name != "") {
                      // print(name);

                      if (!files.contains(name))
                        setState(() {
                          files[index] = name;
                          Navigator.pop(context);
                        });
                      else {
                        myToast(
                            'Folder with this name already exists', Colors.red);
                      }
                    } else {
                      myToast('Enter folder name', Colors.red);
                    }
                  },
                  child: Text('Create')),
            ],
          );
        });
  }

  onCreateFolder() {
    var name = "";
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text('Create New Folder'),
              content: TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Folder Name",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
              contentPadding: EdgeInsets.only(top: 20, left: 24, right: 24),
              titlePadding: EdgeInsets.only(top: 24, left: 24, right: 24),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: () {
                      if (name != "") {
                        // print(name);

                        if (!files.contains(name))
                          setState(() {
                            // files.add(name);
                            Navigator.pop(context);
                          });
                        else {
                          myToast(
                              'File with this name already exists', Colors.red);
                        }
                      } else {
                        myToast('Enter file name', Colors.red);
                      }
                    },
                    child: Text('Create')),
              ],
            ),
          );
        });
  }

  onReadFile(index) async {
    var file = files[index];

    MyListFiles.filename = file;

    var url = Uri.parse(
        'http://${ip}/cgi-bin/listfiles/readfile.py?name=sidd&lan=$language&file=$file');
    try {
      var response = await http.get(url, headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      });
      var code = response.statusCode;
      print(code);
      if (code == 200) {
        var body = response.body;
        print(body);

        setState(() {
          body = body.replaceAll('<<<', '"');
          MyListFiles.data = body;
        });
        if (language == 'python') {
          Navigator.pushNamed(context, 'pythoncode');
        } else if (language == 'c') {
          Navigator.pushNamed(context, 'ccode');
        } else if (language == 'cpp') {
          Navigator.pushNamed(context, 'cppcode');
        }
      } else {
        print('invalid IP');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your files'),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onCreateFolder();
          },
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  print(index);
                  onReadFile(index);
                },
                child: Container(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Icon(
                            Icons.code,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            files[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(child: Container()),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: Icon(Icons.more_vert),
                              items: <String>[
                                'Rename',
                                'Delete',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  if (value == 'Delete') {
                                  } else if (value == 'Rename') {
                                    onRenameFolder(index);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
