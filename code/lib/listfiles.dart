import 'package:developer_assistant/ip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyListFiles extends StatefulWidget {
  const MyListFiles({Key key}) : super(key: key);

  @override
  _MyListFilesState createState() => _MyListFilesState();
}

class _MyListFilesState extends State<MyListFiles> {
  String ip;
  List files = [];

  void initApp() async {
    var url = Uri.parse('http://${ip}/cgi-bin/listfiles/listfiles.py?x=sidd');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your files'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
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
                                } else if (value == 'Rename') {}
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
              );
            }),
      ),
    );
  }
}
